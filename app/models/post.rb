class Post < ActiveRecord::Base
    acts_as_votable
    act_as_bookmarkee
    belongs_to :doctor, counter_cache: :post_count
    has_many :comment, dependent: :destroy
    belongs_to :phase
    belongs_to :issue
    belongs_to :user
    validates_length_of :title, :maximum => 90 
    validates_presence_of :subject, :message => "請記得輸入"
    validates_presence_of :title, :message => "請記得輸入" 
    validates_presence_of :description, :message => "請記得輸入" 
    validates_presence_of :phase_id, :message => "請記得選擇"
    validates_presence_of :issue_id, :message => "請記得選擇"

    
    
    
    def self.choose_phase(t)
        where(["phase_id = ? ", t ]).order('id DESC').limit(3)
    end
    
    filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
		available_filters: [
    		:sorted_by,
    		:search_query,
    		:with_phase_id,
    		:with_issue_id,
    		]
    )
	
	scope :with_phase_id, lambda { |phase_ids|
    where(:phase_id => [*phase_ids])
  }
  
  scope :with_issue_id, lambda { |issue_ids|
    where(:issue_id => [*issue_ids])
  }
  
  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("posts.created_at #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }
  
  def self.options_for_sorted_by
    [
      #['Name (a-z)', 'name_asc'],
      #['Registration date (newest first)', 'created_at_desc'],
      #['Registration date (oldest first)', 'created_at_asc'],
      #['City (a-z)', 'city_name_asc'],
      ['依照留言時間( 新 -> 舊 )', 'created_at_desc'],
      ['依照留言時間( 舊 -> 新 )', 'created_at_asc']
    ]
    end
  
  
    
    #scope :with_subject, lambda { |subject|
    #where(:subject => [*subject])
  #}
    #scope :with_period, lambda { |period|
    #where(:period => [*period])
  #}
    #scope :with_kind, lambda { |kind|
    #where(:kind => [*kind])
  #}
  	
  	#filterrific(
    #	default_filter_params: { sorted_by: 'created_at_desc' },
	#	available_filters: [
    #		#:sorted_by,
    #		#:search_query,
    #		:with_subject,
    #		:with_period,
    #		:with_kind,
    #		]
    #)
    
    
    
    
    
    
    
    
    
    
    SUBJECT = [['其他' , 0],['心得分享' , 1],['疑問求解' , 2]]
    PERIOD = [['其他' , 0],['第12週以前' , 1],['第12 - 20週' , 2],['第21 - 28週' , 3],['第29 - 40週' , 4],['新生兒' , 5]]
    KIND = [
        ['其他' , 0],
        ['疾病史' , 1],
        ['遺傳性疾病' , 2],
        ['婚前健康檢查' , 3],
        ['身體檢查' , 4],
        ['生活飲食與體重控制' , 5],
        ['休閒、旅遊與運動' , 6],
        ['身體不適狀況' , 7],
        ['抽煙喝酒' , 8],
        ['孕婦使用藥品' , 9],
        ['孕婦化妝品' , 10],
        ['孕婦性生活' , 11],
        ['陰道出血' , 21],
        ['貧血' , 22],
        ['Ｂ型肝炎' , 23],
        ['德國麻疹' , 24],
        ['性傳染病檢查' , 25],
        ['超音波檢查' , 26],
        ['高層次超音波檢查' , 27],
        ['羊膜穿刺與唐氏症' , 28],
        ['羊水晶片' , 29],
        ['子癲前症' , 30],
        ['乙型鏈球菌篩檢' , 31],
        ['妊娠糖尿病' , 32],
        ['妊娠高血壓' , 33],
        ['胎兒狀況與胎動' , 34],
        ['準媽媽健康操' , 51],
        ['生產方式' , 52],
        ['胎位' , 53],
        ['羊水' , 54],
        ['陣痛' , 55],
        ['新生兒篩檢' , 56],
        ['產前用品準備' , 57],
        ['嬰兒用品準備' , 58],
        ['產後憂鬱症' , 59],
        ['母乳與配方奶' , 60],
        ['坐月子中心' , 61],
        ['托嬰中心與保母托育' , 62],
        ['準爸爸與新手爸爸' , 63],
        ['政府相關補助' , 64],
        ['健保費用相關' , 65]
        ]
end
