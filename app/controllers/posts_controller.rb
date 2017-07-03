class PostsController < ApplicationController
    before_action :find_doctor, except: [:index, :posts_phase]
    before_action :find_post, only: [:show, :edit, :update, :destroy]
   
    
    
    def index
        @posts = @paginate = Post.all.order('id DESC').paginate(:page => params[:page], :per_page => 6)
        #@posts_phase_one = Post.all.where(:phase_id => "1").order('id DESC').limit(3)
        #@posts = @paginate = @doctor.post.where(:subject => params[:subject][1]).order('id DESC').paginate(:page => params[:page], :per_page => 5)
    end
    
    def posts_phase
        @posts_phase_one = Post.includes(:issue).choose_phase(1)
        @posts_phase_two = Post.includes(:issue).choose_phase(2)
        @posts_phase_three = Post.includes(:issue).where(:phase_id => "3").order('id DESC').limit(3)
        @posts_phase_four = Post.includes(:issue).where(:phase_id => "4").order('id DESC').limit(3)
    end
    
    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        @post.doctor_id = @doctor.id
        if @post.save
			redirect_to doctor_post_path(@doctor, @post)
		else
			render 'new'
		end
    end
    
    def show
        @comments = @paginate = @post.comment.all.order('id DESC').paginate(:page => params[:page], :per_page => 5)
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
    
    private
    def post_params
        params.require(:post).permit(:title, :description, :doctor_id, :subject, :period, :kind, :phase_id, :issue_id)
    end
    
	def find_doctor
		@doctor = Doctor.find(params[:doctor_id])
	end
	def find_post
	    @post = Post.find(params[:id])
	end
	
    
    
end
