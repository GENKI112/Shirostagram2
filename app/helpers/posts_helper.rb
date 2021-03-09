module PostsHelper
  def render_with_hashtags(caption)
    if caption.match(/[#＃]/)
      hashtags = caption.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
      hash_point = hashtags.map do |num|
        top_point = caption.index(num)
        bottom_point = caption.index(num) + num.length - 1
        hash = []
        hash.push(top_point, bottom_point)
      end
      cap_hash = []
      cap_arr = hash_point.each_with_index do |arr, i|
        if i == 0
          front_cap = caption[0...arr[0]]
          cap_hash.push(front_cap)
        else
          space_cap = caption[(hash_point[i-1][1] + 1)...hash_point[i][0]]
          cap_hash.push(space_cap)
        end
        tag = caption[arr[0]..arr[1]]
        cap_hash.push(tag)
      end
      last_cap = caption[(hash_point.last[1] + 1)..-1]
      cap_hash.push(last_cap)
      cap_link = cap_hash.map do |word|
        if word.match(/[#＃]/)
          p link_to word, "/post/hashtag/#{word.delete("#")}"
        else
          p word
        end
      end
    else
      p caption
    end
  end
end
