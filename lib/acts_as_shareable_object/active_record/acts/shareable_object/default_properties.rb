module ActiveRecord
  module Acts
    module ShareableObject
      module DefaultProperties
        TWITTER = [
            twitter: [
              :card,
              :title,
              :description,
              :url,
              :image0,
              :image1,
              :image2,
              :image3,
              :data1,
              :label1,
              :data2,
              :label2,
              image: [
                :src,
                :width,
                :height
              ],
              player: [
                :width,
                :height,
                :stream
              ],
              site: [:id],
              creator: [:id],
              app: [
                name: [
                  :iphone,
                  :ipad,
                  :googleplay
                ],
                id: [
                  :iphone,
                  :ipad,
                  :googleplay 
                ],
                url: [
                  :iphone,
                  :ipad,
                  :googleplay
                ]
              ]
            ]
          ]

          OPEN_GRAPH = [
            og: [
              :title,
              :site_name,
              :url,
              :description,
              :image,
              :type
            ],
            article: [
              :author,
              :publisher
            ]
          ]

          FACEBOOK = [
            fb: [
              :app_id,
              :admin
            ]
          ]

          def self.all
            TWITTER | OPEN_GRAPH | FACEBOOK
          end
      end
    end
  end
end