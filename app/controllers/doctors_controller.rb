class DoctorsController < ApplicationController
	before_action :find_doctor, only: [:show,:edit, :update, :destroy]
	impressionist only: [:show, :index]
	def index
		
		@citys = City.all
		
		# duol selection: phase and issue
		@phase = Phase.includes(:issue).order(:id)
		
		#phase and issue分開
		
		@phases = Phase.all
		@issues = Issue.all
		
		
		
        @issue_1 = @issues.select{|t| t.phase_id == 1} #檢查相關
        @issue_2 = @issues.select{|t| t.phase_id == 2} #孕婦注意事項
        @issue_3 = @issues.select{|t| t.phase_id == 3} #生產相關
        @issue_4 = @issues.select{|t| t.phase_id == 4} #產後注意事項
        
        @phase_1 = @phases.select{|t| t.phasecate_id == 1} #懷孕期間
        @phase_2 = @phases.select{|t| t.phasecate_id == 2} #生產過後
        
        #@phase_1 = @phases.where(:id => (1..4)) #懷孕期間
        #@phase_2 = @phases.where(:id => (5..7)) #生產過後
		
		
		if params[:city].blank?
			@doctors = @paginate = Doctor.includes(:city).includes(:hospital).paginate(:page => params[:page])
			@title = "全部城市"
			#@doctors = @paginate = Doctor
		else
			@city_id = City.find_by(name: params[:city]).id
			#scope 用法
			@doctors = @paginate = Doctor.doctor_city(@city_id).paginate(:page => params[:page])
			@title = params[:city]
			
			#也可以寫成這樣：
			#@doctors = Doctor.where(:city_id => @city_id).order("created_at DESC")
		end
		
		
		
		# 這邊是正確的，先助解掉
		#@filterrific = initialize_filterrific(
		#	Doctor.includes(:city).includes(:hospital).includes(:post),
		#	params[:filterrific],
		#	select_options: {
		#		sorted_by: Doctor.options_for_sorted_by,
		#		with_city_id: City.options_for_select,
		#		with_district_name: District.options_for_select,
		#		with_hospital_id: Hospital.options_for_select
		#	},
    	#	persistence_id: 'shared_key',
    	#	default_filter_params: {},
    	#	#available_filters: [],
    	#	) or return
    	#	@doctors = @filterrific.find.page(params[:page])
		#	respond_to do |format|
		#		format.html
		#		format.js
		#	end
		
		
	end
	
	def most_posts
         @doctors = @paginate = Doctor.all.order('post_count DESC').paginate(:page => params[:page], :per_page => 5)
    end
	
	def show
		@phase = Phase.includes(:issue).order(:id)
		impressionist(@doctor)
		#按主題 - 心得分享與求解
		if params[:subject].blank?
			@posts = @paginate = @doctor.post.all.order('id DESC').paginate(:page => params[:page], :per_page => 5)
			#@posts = @paginate = Post.paginate(:page => params[:page], :per_page => 5).order('id DESC')
		else
		#	@subjects = Post::SUBJECT.find_by(id: params[:subject][1])
		#	#scope 用法
			@posts = @paginate = @doctor.post.where(:subject => params[:subject][1]).order('id DESC').paginate(:page => params[:page], :per_page => 5)
			#@posts = @paginate = Post.paginate(:page => params[:page], :per_page => 5)
			#也可以寫成這樣：
			#@doctors = Doctor.where(:city_id => @city_id).order("created_at DESC")
		end
		
		#按主要範圍
		if params[:kind].blank?
			@posts = @paginate = @doctor.post.all.order('id DESC').paginate(:page => params[:page], :per_page => 5)
		else
			@posts = @paginate = @doctor.post.where(:kind => params[:kind][1]).order('id DESC').paginate(:page => params[:page], :per_page => 5)
		end
		
		#按孕期
		if params[:period].blank?
			@posts = @paginate = @doctor.post.all.order('id DESC').paginate(:page => params[:page], :per_page => 5)
		else
			@posts = @paginate = @doctor.post.where(:period => params[:period][1]).order('id DESC').paginate(:page => params[:page], :per_page => 5)
		end
		
		#按孕期
		if params[:phase].blank?
			@posts = @paginate = @doctor.post.includes(:phase).includes(:issue).order('id DESC').paginate(:page => params[:page], :per_page => 5)
		else
			@posts = @paginate = @doctor.post.includes(:phase).includes(:issue).where(:phase => params[:phase]).order('id DESC').paginate(:page => params[:page], :per_page => 5)
		end
		
		
		
		
		@phases = Phase.all
		@issues = Issue.all
		
		
		
        @issue_1 = @issues.select{|t| t.phase_id == 1} #檢查相關
        @issue_2 = @issues.select{|t| t.phase_id == 2} #孕婦注意事項
        @issue_3 = @issues.select{|t| t.phase_id == 3} #生產相關
        @issue_4 = @issues.select{|t| t.phase_id == 4} #產後注意事項
        
        @phase_1 = @phases.select{|t| t.phasecate_id == 1} #懷孕期間
        @phase_2 = @phases.select{|t| t.phasecate_id == 2} #生產過後
        
        #@phase_1 = @phases.where(:id => (1..4)) #懷孕期間
        #@phase_2 = @phases.where(:id => (5..7)) #生產過後
		
		
	#		@filterrific = initialize_filterrific(
	#		Doctor,
	#		params[:filterrific],
	#		select_options: {
	#			sorted_by: @doctor.post.options_for_sorted_by,
	#			with_subject:@doctor.post.subject.options_for_select,
	#			with_period: @doctor.post.period.options_for_select,
	#			with_kind: @doctor.post.kind.options_for_select
	#		},
    #		persistence_id: 'shared_key',
    #		default_filter_params: {},
    		#available_filters: [],
    #		) or return
    	#	@doctors = @filterrific.find.page(params[:page])
	#		respond_to do |format|
	#			format.html
	#			format.js
	#		end
	
	end

	def new
		@doctor = Doctor.new
	end

	def create
		@doctor = Doctor.new(doctor_params)
		if @doctor.save
			redirect_to doctor_path(@doctor)
		else
			render 'new'
		end
	end
	

	def edit
	end

	def update
		if @doctor.update(doctor_params)
			redirect_to doctor_path(@doctor)
		else
			render 'edit'
		end
	end

	private
	
	def doctor_params
		params.require(:doctor).permit(:name, :specialty, :experience, :doctor_img)
	end

	def find_doctor
		@doctor = Doctor.find(params[:id])
	end
end
