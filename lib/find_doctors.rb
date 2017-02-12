#require 'active_record'
require 'open-uri'
require 'nokogiri'

class Find_Doctors

	def self.run

		html = open('http://www.tmuh.org.tw/team/team/053/053/050216').read
		doc = Nokogiri::HTML(html)
		#名稱
		
		name = doc.css('//h2').text.strip
		
		#圖檔
		img = doc.css('#MainPlaceHolder_imgPhoto')
		img_url = img.attr('src')
		profile_img = "http://www.tmuh.org.tw#{img_url}"
		`wget -P /Users/tienshunlo/workspace/broadway/app/assets/images -O /Users/tienshunlo/workspace/broadway/app/assets/images/#{name}.jpg  #{profile_img}`
        #`wget --output-document="/Users/tienshunlo/workspace/broadway/app/assets/images/123.jpg" --directory-prefix="/Users/tienshunlo/workspace/broadway/app/assets/images"  #{profile_img}`

        #學歷、經歷、專科證書名稱
		ans = []
		ans = doc.css('.col-sm-8 > p').to_html.scan(/>([^\n><]+)</).flatten.map{|i| i.gsub(/•/ , '').gsub(/&nbsp;/ , '').gsub(/\u00a0/, '').strip}.delete_if{|i|i.empty?}

		temp = []
		ans.each do |str|
		  case str
		  when "學歷" , "經歷" , "專科證書名稱"
		    temp << []
		  else
		    temp[-1] << str
		  end
		end

		#新增Play
		@doctor = Doctor.new
		@doctor.name = name
		@doctor.play_img = File.open("app/assets/images/#{name}.jpg",'r')
		#File.new("/path/to/image.jpg","r")
		#File.open('/path/to/image.jpg', 'r'))
		@doctor.specialty = temp[1].join("<p>")
		@doctor.experience = temp[2].join("<p>")
		@doctor.save

		
	end
end






