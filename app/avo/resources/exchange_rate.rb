class Avo::Resources::ExchangeRate < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }
  
  def fields
    field :id, as: :id
    field :currency, as: :belongs_to
    field :ex_rate, as: :number
    field :quantity, as: :number
    field :valid_from, as: :date
    field :valid_to, as: :date
    field :active, as: :boolean
  end
end


