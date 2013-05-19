class Character::Admin::ApiController < Character::Admin::BaseController
  before_filter :set_model_class
  before_filter :set_form_template, only: %w( new edit create update )
  before_filter :set_admin_user_id, only: %w( create update )

  def set_form_template
    # Check if there is a custom form template for the class in the
    # character/admin/ folder, if not using generic form

    template_folder = @namespace.to_s.pluralize

    if template_exists?("form", "character/admin/#{ template_folder }", false)
      @form_template = "character/admin/#{ template_folder }/form"
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


  def set_admin_user_id
    params[@namespace][:admin_user_id] = @character_admin_user.id
  end


  def index
    search_query  = params[:search_query] || ''
    page          = params[:page]         || 1
    per_page      = params[:per_page]     || 10

    @objects = @model_class.all

    @objects = @objects.full_text_search(search_query) if not search_query.empty?
    @objects = @objects.page(page).per(per_page)

    object_hashes = @objects.map(&:serializable_hash)
    object_hashes.each do |h|
      h["_id"] = h["_id"].to_s
    end

    render json: {  objects:       object_hashes,
                    total_pages:   @objects.total_pages(),
                    page:          page,
                    per_page:      per_page,
                    search_query:  search_query }
  end


  def show
    @object = @model_class.find(params[:id])
    data = @object.serializable_hash.merge(_id: @object.id.to_s)
    render json: data
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
    #TODO calling permit! is insecure, we must get rid of it in future
    @object = @model_class.create @model_class.admin_permit_params(params[@namespace])

    if @object.save
      render json: @object
    else
      render @form_template, layout: false
    end
  end


  def update
    @object = @model_class.find(params[:id])

    #TODO calling permit! is insecure, we must get rid of it in future
    if @object.update_attributes @model_class.admin_permit_params(params[@namespace])
      data = @object.serializable_hash.merge(_id: @object.id.to_s)
      render json: data
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


