module ApplicationHelper
    
    def login_helper style = ''
        if current_user
          (link_to "個人後台", dashboard_posts_path, class:style) +
          (link_to "登出", destroy_user_session_path, method: :delete, class:style)
        else
          (link_to "註冊", new_user_registration_path, class:style) +
          (link_to "登入", new_user_session_path, class:style)
        end
    end
    
    
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
    
    def doctor_img_missing_helper(layout, doctor)
        doctor_image = image_path("medium/missing.png")
        if layout == "missing"
            link_to "", doctor_path(doctor), { class: "u-block", 
                                                style: "background-image: url('#{doctor_image}');
                                                        height: 10rem;"
                                                }
        end
    end
    
    def doctor_img_helper(layout, doctor)
        if doctor.album
            doctor_image = doctor.album.album_img.url(:medium) 
        else
            doctor_image = image_path("medium/missing.png")
        end
        if layout == "index"
            link_to "", doctor_path(doctor), { class: "u-block", 
                                                style: "background-image: url('#{doctor_image}'); 
                                                        height: 10rem;"
                                                } 
        elsif layout == "show"
            link_to "", doctor_path(doctor), { class: "u-block size10x10 radius100", 
                                                style: "background-image: url('#{doctor_image}');"
                                                }
        elsif layout == "dashboard"
            link_to "", doctor_path(doctor), { class: "u-block size6x6 radius100", 
                                                style: "background-image: url('#{doctor_image}');"
                                                }
        elsif layout == "small-poster"
            link_to "", "#", { class: "u-block size3x3 radius100", 
                                style: "background-image: url('#{doctor_image}');" 
                                }
        end
    end
    
    
    def user_img_helper(layout, user)
        
        if user.profile.album
            user_image = user.profile.album.album_img.url(:medium) 
        else
            user_image = user.profile.profile_img.url(:medium)
        end
        
        if layout == "small-poster"
            link_to "", user_path(user), { class: "u-block size3x3 radius100", 
                                            style: "background-image: url('#{user_image}')" 
                                            }
        elsif layout == "big-poster"
            link_to "", user_path(user), { class: "u-block size7x7 radius100", 
                                            style: "background-image: url('#{user_image}')"
                                            }
        elsif layout == "show-poster"
            link_to "", user_path(user), { class: "u-block size375x375 radius100", 
                                            style: "background-image: url('#{user_image}')"
                                            }
        end
    end
    
    def doctor_album_button(doctor, style = 'button MarginTop05')
        if doctor.album 
            link_to "更新圖片", edit_dashboard_mamabook_doctor_doctor_album_path(:doctor_id => doctor.id, :id => doctor.doctor_album), class: "#{style}"
		else 
			link_to "新增圖片", new_dashboard_mamabook_doctor_doctor_album_path(doctor.id), class: "#{style}"
	    end 
	end
	
	def user_album_button(user, style = 'button MarginTop1 Width100')
        if user.profile.album 
            link_to "更新圖片", edit_dashboard_profile_profile_album_path(current_user.profile.profile_album), class: "#{style}"
		else 
			link_to "更新圖片", new_dashboard_profile_profile_album_path, class: "#{style}"
	    end 
	end
	
	def login_post_button (current_user, doctor, style = '')
	    if current_user
    		link_to "留言", new_doctor_post_path(doctor), class: "button #{style}" 
	    else
		    link_to "登入留言", new_user_session_path, class: "button #{style}"
	    end
	end
	
	
	
	def active_category? avatar, album
        "active" if avatar == album
    end
    
    def active_nav? path
        "active" if current_page? path
    end
    
    def dashboard_nav_items
        [
            {
                url: dashboard_profile_path,
                title: "個人資料"
            },
            {
                url: edit_dashboard_profile_path,
                title: "修改個資"
            },
            {
                url: edit_registration_dashboard_profile_path,
                title: "更新帳密"
            },
            {
                url: dashboard_doctors_path,
                title: "關注的醫生"
            },
            {
                url: dashboard_posts_path,
                title: "發表的文章"
            },
        ]
    end
    
    def mamabook_nav_items
        [
            {
                url: dashboard_mamabook_doctors_path,
                title: "醫生"
            },
            {
                url: dashboard_mamabook_posts_path,
                title: "留言"
            },
            {
                url: dashboard_mamabook_albums_path,
                title: "相簿"
            },
        ]
    end
    
    def dashboard_nav(items, style)
        dashboard_nav = ""
        items.each do |item|
            dashboard_nav << "<li><a href='#{item[:url]}' class='#{style} #{active_nav? item[:url]}'> #{item[:title]} </a></li>"
        end
        dashboard_nav.html_safe
    end
						
end

