module PostsHelper
  def return_an_array(caption)
    hashtags = Post.hashtag_scan(caption)
    dup_hash = {}
    hashtags.uniq.each do |word|
      dup_hash[word] = 0
    end
    hash_point = hashtags.map do |num|
      top_point = caption.index(num, dup_hash[num])
      bottom_point = caption.index(num, dup_hash[num]) + num.length - 1
      dup_hash[num] = bottom_point
      hash_point =  top_point, bottom_point
    end
    cap_arr = []
    hash_point.each_with_index do |arr, i|
      usually_cap = caption[
        if cap_arr.empty?
          0...hash_point[0][0]
        else
          (hash_point[i-1][1] + 1)...hash_point[i][0]
        end
      ]
      tag = caption[arr[0]..arr[1]]
      cap_arr.push(usually_cap, tag)
    end
    last_cap = caption[
      if caption.match(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
        (hash_point.last[1] + 1)..-1
      else
        0..-1
      end
    ]
    cap_arr.push(last_cap)
    cap_arr.map do |word|
      if word.match(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
        delete_pound_word = word.delete(word[0])
        p link_to word, "/post/hashtag/" + delete_pound_word
      else
        p word
      end
    end
  end
end
