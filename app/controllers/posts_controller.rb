class PostsController < ApplicationController
    before_action :find_doctor, except: [:index, :posts_phase, :posts_issue, :phase_issue]
    before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
    before_action :find_issues_and_phases, only: [:new, :create, :edit]
    layout "posts"
    
    def index
        @flex_filter_icon ="dvr"
        #filterrific版本
		@filterrific = initialize_filterrific(
			Post.includes(:phase, :issue),
			params[:filterrific],
			select_options: {
				sorted_by: Post.options_for_sorted_by,
				with_phase_id: Phase.options_for_select,
				with_issue_id: Issue.options_for_select
			},
    		persistence_id: 'shared_key',
    		default_filter_params: {},
    		#available_filters: [],
    		) or return
    		@posts = @paginate = @filterrific.find.paginate(:page => params[:page], :per_page => 6)
    		#@title = @posts.first.phase.title || @posts.first.issue.title
			respond_to do |format|
				format.html
				format.js
			end
       
    end
    
    def posts_phase
        #按孕期的大項分類
        @flex_filter_title = "按孕期排序"
        @flex_filter_icon ="pregnant_woman"
        @filter_anchor = @post_cates = @phases = Phase.all
        @posts_tag = Post.all.includes(:phase, :issue).includes(:doctor).order('id DESC')
    end
    
    
    def posts_issue
        #按症狀的大項分類
        @flex_filter_title = "按症狀排序"
        @flex_filter_icon ="child_care"
        @filter_anchor =  @post_cates = @issues = Issue.all
        @posts_tag = Post.all.includes(:phase, :issue, :doctor).order('id DESC')
    end
    
    def phase_issue
        #按孕期與症狀的細項分類
        @phases = Phase.all
        if params[:phase]
            @posts = @paginate = Post.all.includes(:phase, :issue, :doctor).where(:phase_id => params[:phase]).order('id DESC').paginate(:page => params[:page], :per_page => 6)
            @title = Phase.find_by(:id => params[:phase]).title
        elsif params[:issue]
            @posts = @paginate = Post.all.includes(:phase, :issue, :doctor).where(:issue_id => params[:issue]).order('id DESC').paginate(:page => params[:page], :per_page => 6)
            @title = Issue.find_by(:id => params[:issue]).title
        else
            render 'index'
        end
    end
    
    def new
        redirect_to new_user_session_path if !current_user
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        @post.doctor_id = @doctor.id
        @post.user_id = current_user.id
        if @post.save
			redirect_to doctor_post_path(@doctor, @post)
		else
			render "new"
		end
    end
    
    def show
        @comments =  @post.comment.all.order('id DESC').paginate(:page => params[:page], :per_page => 5)
    end
    
    def edit
    end
    
    def update
        if @post.update(post_params)
            redirect_to doctor_post_path(@doctor, @post)
        else
            render 'edit'
        end
    end
    
	def destroy
	    @doctor = Doctor.find(params[:doctor_id])
	    @post = @doctor.post.find(params[:id])
		@post.destroy
		redirect_to doctor_path(@doctor)
	end
	
	def upvote
	    @doctor = Doctor.friendly.find(params[:doctor_id])
	    @post.upvote_by current_user
	    redirect_to doctor_post_path(@doctor, @post)
    end
    
    def downvote
        @doctor = Doctor.friendly.find(params[:doctor_id])
        @post.downvote_by current_user
        redirect_to doctor_post_path(@doctor, @post)
    end
    
    private
    def post_params
        params.require(:post).permit(:title, :description, :subject, :phase_id, :issue_id, :doctor_id, :user_id)
    end
    
	def find_doctor
		@doctor = Doctor.friendly.find(params[:doctor_id])
	end
	def find_post
	    @post = Post.find(params[:id])
	end
	def find_issues_and_phases
	    @issues = Issue.all
        @issue_1 = @issues.select{|t| t.phase_id == 1}  #檢查相關
        @issue_2 = @issues.select{|t| t.phase_id == 2} #孕婦注意事項
        @issue_3 = @issues.select{|t| t.phase_id == 3} #生產相關
        @issue_4 = @issues.select{|t| t.phase_id == 4} #產後注意事項
        
        @phases = Phase.all
        @phase_1 = @phases.select{|t| t.phasecate_id == 1} #懷孕期間
        @phase_2 = @phases.select{|t| t.phasecate_id == 2} #生產過後後
	end
end
