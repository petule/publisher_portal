module CategoriesHelper
  def pluralize_ebooks(count)
    word = case count
           when 1 then t('dials.pluralize_ebooks.one')
           when 2..4 then t('dials.pluralize_ebooks.more')
           else t('dials.pluralize_ebooks.many')
           end
    "#{count} #{word}"
  end
end
