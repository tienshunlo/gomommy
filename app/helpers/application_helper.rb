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
        if layout == "index"
            link_to "", "#{doctor_path(avatar)}", { class: "u-block", 
                                                    style: "background-image: url('#{avatar.doctor_img.url(:medium)}'); 
                                                            height: 10rem;"
                                                    } 
            
        elsif layout == "profile"
            link_to "", "#{doctor_path(avatar)}", { class: "u-block size10x10 radius100", 
                                                    style: "background-image: url('#{avatar.doctor_img.url(:medium)}');"
                                                    }
        elsif layout == "small-poster"
            link_to "", "#{doctor_path(avatar)}", { class: "u-block size3x3 radius100", 
                                                    style: "background-image: url('#{avatar.doctor_img.url(:medium)}');" 
                                                    }
        elsif layout == "big-poster"
            content_tag("a", 
                        nil, 
                        href:  "#{doctor_path(avatar)}",
                        class: "u-block size375x375 radius100", 
                        style: "background-image: url('#{avatar.doctor_img.url(:medium)}'); 
                                " 
                        )
        end
    end
    
    
end

