class Post < ActiveRecord::Base
    
    belongs_to :doctor, counter_cache: :post_count
    has_many :comment, dependent: :destroy
    
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
