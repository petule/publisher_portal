module Authors
  class AuthorTypeMatcher
    prepend SimpleCommand

    attr_reader :query
    def initialize(query)
      @query = query
    end

    def call
      return nil if query.blank?

      normalized_query = I18n.transliterate(query.downcase)

      translations = I18n.t('dials.author_type')
      found = translations.find do |_, translated|
        normalized_translated = I18n.transliterate(translated.downcase)
        normalized_translated.include?(normalized_query)
      end

      found&.first&.to_sym
    end
  end
end
