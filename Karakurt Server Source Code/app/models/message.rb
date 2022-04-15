class Message < ApplicationRecord
  acts_as_textcaptcha raise_errors: false,
                      cache_expiry_minutes: 10,
                      questions: [
                        { 'question' => '1+1', 'answers' => '2,two' },
                        { 'question' => 'The green hat is what color?', 'answers' => 'green' },
                        { 'question' => 'How many days do we have in a week?', 'answers' => '7,seven' },
                        { 'question' => 'How many days are there in a normal year?', 'answers' => '365' },
                        { 'question' => 'How many sides are there in a triangle?', 'answers' => '3,three' },
                        { 'question' => 'Which month of the year has the least number of days?', 'answers' => 'february,feb' },
                        { 'question' => 'Which animal is called King of Jungle?', 'answers' => 'lion' },
                        { 'question' => 'Which planet is known as the red planet?', 'answers' => 'Mars' },
                        { 'question' => 'How many hours do we have in a day?', 'answers' => '24,24 hours' },
                        { 'question' => 'What colors are the stars on the American flag?', 'answers' => 'white' },
                        { 'question' => 'If you freeze water, what do you get?', 'answers' => 'ice' },
                        { 'question' => 'What is the color of a school bus?', 'answers' => 'yellow' },
                        { 'question' => 'What do bees make?', 'answers' => 'honey' },
                        { 'question' => 'What kind of animal was Abu in Aladdin?', 'answers' => 'monkey' },
                        { 'question' => 'What color are Smurfs?', 'answers' => 'blue' },
                        { 'question' => 'Name Batman’s crime-fighting partner?', 'answers' => 'robin' },
                        { 'question' => 'Which is the nearest star to planet earth?', 'answers' => 'sun' },
                        { 'question' => 'Which is the principal source of energy for earth?', 'answers' => 'sun' },
                        { 'question' => 'How many legs does a spider have?', 'answers' => '8,eight' },
                        { 'question' => 'Which superhero can climb up walls and buildings?', 'answers' => 'spiderman' },
                        { 'question' => 'In which capital city of Europe would you find the Eiffel Tower?', 'answers' => 'paris' },

                      ]
end