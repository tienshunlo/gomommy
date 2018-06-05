class CommentsController < ApplicationController
    before_action :find_doctor
    before_action :find_post
    before_action :find_comment, only: [:show, :edit, :update, :destroy]

    def create
        @comment = @post.comment.build(comment_params)
        @comment.user_id = current_user.id
        respond_to do |format|
          if @comment.save
            format.html { redirect_to doctor_post_path(@doctor, @post) }
            format.js   { }
          else
            format.html { render :new }
            format.js # call create.js.erb on save errors
            format.json { render json: @comment.errors, status: :unprocessable_entity }
          end
        end
    end
    def edit
    end
    def update
        @comment.update(comment_params)
        respond_to do |format|
            format.html { redirect_to doctor_post_path(@doctor, @post) }
            format.js { }
        end
    end
    
    def destroy
        @comment.destroy
    end
    
    private
    
    def comment_params
        params.require(:comment).permit(:content)
    end
    def find_doctor
		@doctor = Doctor.friendly.find(params[:doctor_id])
	end
	def find_post
	    @post = Post.find(params[:post_id])
	end
	def find_comment
	    @comment = Comment.find(params[:id])
	end
    
    
end
