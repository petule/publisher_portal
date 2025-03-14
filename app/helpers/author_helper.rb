module AuthorHelper
  def sort_link(column, label)
    direction = params[:order] == column && params[:direction] == 'asc' ? 'desc' : 'asc'
    icon = params[:order] == column ? (params[:direction] == 'asc' ? '▲' : '▼') : ''
    query = params[:query] || ''

    link_to "#{label} #{icon}".html_safe, authors_path(order: column, direction: direction, query: query),
            data: { turbo_frame: 'result', turbo_stream: 'update' }, class: 'sort-link'
  end
end
