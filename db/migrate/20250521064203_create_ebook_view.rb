class CreateEbookView < ActiveRecord::Migration[8.0]
  def up
    execute <<~SQL
CREATE OR REPLACE VIEW ebooks_view AS
      SELECT
    ebooks.id,
    ebooks.title as ebook_title,
    publishers.title as publisher_title,
    languages.name AS language_name,
    STRING_AGG(a.first_name, ', ') AS authors
FROM
    ebooks
        JOIN publishers ON ebooks.publisher_id = publishers.id
        JOIN languages ON ebooks.language_id = languages.id
        left join ebook_authors ea on (ea.ebook_id = ebooks.id)
        left join authors a on (ea.author_id = a.id)

group by ebooks.id,
         ebooks.title,
         publishers.title,
         languages.name
    SQL
  end

  def down
    execute "DROP VIEW IF EXISTS ebooks_view"
  end
end
