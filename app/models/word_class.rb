class WordClass < ActiveHash::Base
  self.data = [
    { id: 1, name:  '---' },
    { id: 2, name:  'noun' },
    { id: 3, name:  'verb' },
    { id: 4, name:  'i-adjective' },
    { id: 5, name:  'na-adjective' },
    { id: 6, name:  'adnominal' },
    { id: 7, name:  'adverb' },
    { id: 8, name:  'conjunction' },
    { id: 9, name:  'grammar' },
    { id: 10, name: 'conversation' }
  ]
end
