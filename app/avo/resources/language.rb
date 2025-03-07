class Avo::Resources::Language < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }
  
  def fields
    field :id, as: :id
    field :name, as: :text
    field :code, as: :text
    field :url, as: :text
    field :active, as: :boolean
  end
end


