class Avo::Resources::Author < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }
  
  def fields
    field :id, as: :id
    field :first_name, as: :text
    field :last_name, as: :text
    field :degree, as: :text
    field :content, as: :textarea
    field :active, as: :boolean
    field :product_content, as: :textarea
  end
end


