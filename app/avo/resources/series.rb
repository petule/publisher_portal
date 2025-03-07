class Avo::Resources::Series < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }
  
  def fields
    field :id, as: :id
    field :title, as: :text
    field :subtitle, as: :text
    field :short_content, as: :textarea
    field :content, as: :textarea
    field :video, as: :text
    field :isbn_epub, as: :text
    field :isbn_mobi, as: :text
    field :isbn_pdf, as: :text
    field :active, as: :boolean
  end
end


