class Avo::Resources::Ebook < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }
  
  def fields
    field :id, as: :id
    field :title, as: :text
    field :original_title, as: :text
    field :subtitle, as: :text
    field :short_content, as: :text
    field :content, as: :textarea
    field :anotation, as: :textarea
    field :video, as: :text
    field :isbn, as: :text
    field :isbn_epub, as: :text
    field :isbn_mobi, as: :text
    field :isbn_pdf, as: :text
    field :series, as: :belongs_to
    field :percentage_preview, as: :number
    field :language, as: :belongs_to
    field :activate_at, as: :date_time
    field :change_at, as: :date_time
    field :active, as: :boolean
    field :internal_number, as: :text
    field :publisher, as: :belongs_to
    field :part, as: :number
    field :publication_year, as: :number
    field :page_count, as: :number
    field :publication_place, as: :number
    field :licence_end_at, as: :date_time
    field :sale_start_at, as: :date_time
    field :sale_end_at, as: :date_time
    field :url, as: :text
    field :sponsored, as: :boolean
  end
end


