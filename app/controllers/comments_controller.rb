class CommentsController < ApplicationController
    before_action :find_doctor
    before_action :find_post
    before_action :find_comment, only: [:show, :edit, :update, :destroy]

    def new
        @comment = Comment.new
    end
    
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comment.create(comment_params)
		
		

		if @comment.save
			redirect_to doctor_post_path(@doctor, @post)
		else
			render 'new'
		end
    end
    def edit
        @post = Post.find(params[:post_id])
        @comments = @post.comment.all
        
    end
    
    def update
        @post = Post.find(params[:post_id])
        if @comment.update(comment_params)
            redirect_to doctor_post_path(@doctor, @post)
        else
            render 'edit'
        end
    end
    
    def destroy
        @comment.destroy
        redirect_to doctor_post_path(@doctor, @post), notice: 'Comment was removed.'
    end
    
    private
    
    def comment_params
        params.require(:comment).permit(:content)
    end
    def find_doctor
		@doctor = Doctor.find(params[:doctor_id])
	end
	def find_post
	    @post = Post.find(params[:post_id])
	end
	def find_comment
	    @comment = Comment.find(params[:id])
	end
    
    
end
