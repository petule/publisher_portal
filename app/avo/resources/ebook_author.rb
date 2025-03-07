class Avo::Resources::EbookAuthor < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }
  
  def fields
    field :id, as: :id
    field :ebook, as: :belongs_to
    field :author, as: :belongs_to
  end
end


