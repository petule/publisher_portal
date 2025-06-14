module EbooksHelper
  def ebook_sort_link(column, label)
    direction = params[:order] == column && params[:direction] == 'asc' ? 'desc' : 'asc'
    icon = params[:order] == column ? (params[:direction] == 'asc' ? '▲' : '▼') : ''
    query = params[:query] || ''

    link_to "#{label} #{icon}".html_safe, ebooks_path(order: column, direction: direction, query: query),
            data: { turbo_frame: 'result', turbo_stream: 'update' }, class: 'sort-link'
  end

  def display_actions?
    params[:controller] == 'ebooks' && (params[:display_actions].nil? || params[:display_actions] == 'true')
  end
end
