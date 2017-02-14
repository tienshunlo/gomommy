class DoctorsController < ApplicationController
	before_action :find_doctor, only: [:show,:edit, :update, :destroy]
	
	def index
		@doctors = Doctor.all
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
