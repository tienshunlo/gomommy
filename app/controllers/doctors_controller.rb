class DoctorsController < ApplicationController
	before_action :find_doctor, only: [:show,:edit, :update, :destroy]
	impressionist only: [:show, :index]
	def index
		if params[:city].blank?
			@doctors = Doctor.all
			@doctors = @paginate = Doctor.paginate(:page => params[:page])
		else
			@city_id = City.find_by(name: params[:city]).id
		#	#scope 用法
			@doctors = @paginate = Doctor.doctor_city(@city_id).paginate(:page => params[:page])
			
			#也可以寫成這樣：
			#@doctors = Doctor.where(:city_id => @city_id).order("created_at DESC")
		end
		
		
		
		
		#@filterrific = initialize_filterrific(
		#	Doctor,
		#	params[:filterrific],
		#	select_options: {
		#		sorted_by: Doctor.options_for_sorted_by,
		#		with_city_id: City.options_for_select,
		#		with_district_id: District.options_for_select,
		#		with_hospital_id: Hospital.options_for_select
		#	},
    	#	persistence_id: 'shared_key',
    	#	default_filter_params: {},
    		#available_filters: [],
    	#	) or return
    	#	@doctors = @filterrific.find.page(params[:page])
		#	respond_to do |format|
		#		format.html
		#		format.js
		#	end
	end
	
	def show
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
