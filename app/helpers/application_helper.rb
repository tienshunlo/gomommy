module ApplicationHelper
    def flex_filterbar(source)
        if source == @filter_anchor
            render 'shared/posts_issue'
        elsif source == @citys
            render 'shared/doctor_index_filter'
        elsif 
            render 'shared/doctor_show_filter'
        end
    end
end

# https://github.com/jordanhudgens/devcamp-portfolio/blob/master/app/helpers/application_helper.rb
