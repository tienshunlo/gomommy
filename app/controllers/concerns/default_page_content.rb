module DefaultPageContent
    extend ActiveSupport::Concern
    included do
        before_action :set_page_defaults
    end
  
    def set_page_defaults
        @page_title = "MaMaBook"
        @seo_keywords = "媽媽手冊"
    end
end