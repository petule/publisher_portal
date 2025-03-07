class Avo::Resources::EbookPrice < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }
  
  def fields
    field :id, as: :id
    field :base_price, as: :number
    field :price, as: :number
    field :currency, as: :belongs_to
    field :ebook, as: :belongs_to
    field :valid_from, as: :date
    field :valid_to, as: :date
    field :active, as: :boolean
  end
end


