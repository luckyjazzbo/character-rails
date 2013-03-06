class Character::Admin::ApiController < Character::Admin::BaseController
  before_filter :set_model_class
  before_filter :set_form_template, only: %w( new edit create update )

  def set_form_template
    # Check if there is a custom form template for the class in the
    # character/admin/api folder, if not using generic form
    if template_exists?("#{@namespace}_form", "character/admin/api", false)
      @form_template = "character/admin/api/#{ @namespace }_form"
    else
      @form_template = "character/admin/api/generic_form"
    end
  end


  def set_model_class
    # Generating class name from the url slug, where '::' replaced with '-'
    # For example: Character-Post -> Character::Post
    @model_slug  = params[:model_slug]
    @model_class = @model_slug.gsub('-', '::').constantize
    @namespace   = @model_class.name.underscore.gsub('/', '_').to_sym
  end


  def index
    query     = params[:q]
    page      = params[:page]
    per_page  = params[:per_page] || 10

    @objects = @model_class.all

    @objects = @objects.full_text_search(query)   if query
    @objects = @objects.page(page).per(per_page)  if page

    result = { objects: @objects }

    result[:paginate] = { page: page, per_page: per_page, total_pages: @objects.total_pages() } if page
    result[:query]    = query if query

    render json: result
  end


  def show
    @object = @model_class.find(params[:id])
    render json: @object    
  end


  def new
    @object  = @model_class.new
    render @form_template, layout: false
  end  


  def edit
    @object = @model_class.find(params[:id])
    render @form_template, layout: false
  end


  def create
    @object = @model_class.create! params[@namespace]

    if @object.save
      render json: @object
    else
      render @form_template, layout: false
    end
  end


  def update
    @object = @model_class.find(params[:id])
    
    if @object.update_attributes params[@namespace]
      render json: @object
    else
      render @form_template, layout: false
    end
  end


  def destroy
    @object = @model_class.find(params[:id])
    @object.destroy
    render json: 'ok'
  end


  def reorder
    # TODO: need to add reordarable check
    @model_class.reorder(params[:ids])
    render json: 'ok'
  end  
end


