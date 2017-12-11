module ApplicationHelper
    
    def filter_helper(style="chip-filter")
        filter_link = ""
        if @filter_anchor
            @filter_anchor.each do |filter_anchor|
                filter_link << "<li><a href='##{filter_anchor.title}' class='#{style}' >#{filter_anchor.title}</a></li>"
            end
        elsif @citys
            filter_link << "<li><a href='#{doctors_path(city: nil)}' class='#{style}' >全部城市</a></li>"
            @citys.each do |city|
                filter_link << "<li><a href='#{doctors_path(city: city.name)}' class='#{style}' >#{city.name}</a></li>"
            end
        else @phases
            filter_link << "<li><a href='#{doctor_path(@doctor)}' class='#{style}' >ALL</a></li>"
            @phases.each do |phase|
                filter_link << "<li><a href='#{doctor_path(@doctor, phase: phase)}' class='#{style}' >#{phase.title}</a></li>"
            end
        end
        filter_link.html_safe
    end
    
    def background_image_helper(tag_type, doctor, size, width, height, radius)
        content_tag(tag_type, 
                    nil, 
                    :style => " background-image: url(#{doctor.doctor_img.url(size)}); 
                                width: #{width}; 
                                height: #{height}; 
                                background-size: cover; 
                                background-position: 50% 50% !important;
                                border-radius: #{radius};" 
                    )
    end
    
    def background_img_helper(layout, avatar)
        if layout ==  "big-poster"
            content_tag("a", 
                        nil, 
                        href:  "#{doctor_path(avatar)}",
                        class: "u-block size375x375 radius100", 
                        style: "background-image: url('#{avatar.doctor_img.url(:medium)}'); 
                                " 
                        )
        end
    end
    
    def doctor_img_helper(layout, doctor)
        doctor_image = doctor.doctor_img.url(:medium)
        if layout == "index"
            link_to "", "#{doctor_path(doctor)}", { class: "u-block", 
                                                    style: "background-image: url('#{doctor_image}'); 
                                                            height: 10rem;"
                                                    } 
            
        elsif layout == "show"
            link_to "", "#{doctor_path(doctor)}", { class: "u-block size10x10 radius100", 
                                                    style: "background-image: url('#{doctor_image}');"
                                                    }
                                                    
        elsif layout == "dashboard"
            link_to "", "#{doctor_path(doctor)}", { class: "u-block size6x6 radius100", 
                                                    style: "background-image: url('#{doctor_image}');"
                                                    }
        
        elsif layout == "small-poster"
            link_to "", "#", { class: "u-block size3x3 radius100", 
                                                    style: "background-image: url('#{doctor_image}');" 
                                                    }
        end
    end
    
    def poster_img_helper(layout, post)
        poster_image = User.find(post.user_id).profile.profile_img.url(:medium)
        if layout == "small-poster"
            link_to "", "#", { class: "u-block size3x3 radius100", 
                                                    style: "background-image: url('#{poster_image}')" 
                                                    }
        elsif layout == "big-poster"
            link_to "", "#", { class: "u-block size375x375 radius100", 
                                                    style: "background-image: url('#{poster_image}')"
                                                    }
        end
    end
    
    def user_img_helper(layout, current_user)
        user_image = current_user.profile.profile_img.url(:medium)
        if layout == "small-poster"
            link_to "", "#", { class: "u-block size3x3 radius100", 
                                                    style: "background-image: url('#{user_image}')" 
                                                    }
        elsif layout == "big-poster"
            link_to "", "#", { class: "u-block size7x7 radius100", 
                                                    style: "background-image: url('#{user_image}')"
                                                    }
        end
    end
end

