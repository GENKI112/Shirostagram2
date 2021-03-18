module PostsHelper
  def caption_and_hashtags_in_array(caption)
    hashtags = Hashtag.hashtag_scan(caption)
    if hashtags.blank?
      return [caption]
    end
    dup_hash = {}
    hashtags.uniq.each do |word|
      dup_hash[word] = 0
    end
    hash_point = hashtags.map do |num|
      top_point = caption.index(num, dup_hash[num])
      bottom_point = caption.index(num, dup_hash[num]) + num.length - 1
      dup_hash[num] = bottom_point
      [top_point, bottom_point]
    end
    cap_arr = [caption[0...hash_point[0][0]]]
    hash_point.each_with_index do |arr, i|
      tag = caption[arr[0]..arr[1]]
      usually_cap = caption[(hash_point[i-1][1] + 1)...hash_point[(i)][0]]
      cap_arr.push(usually_cap, tag)
    end
    cap_arr.push(caption[(hash_point.last[1] + 1)..-1])
    cap_arr.map do |word|
      if word.match(Hashtag::HASHTAG_CONDITIONS)
        delete_pound_word = Hashtag.pound_delete_at_hashtag(word)
        link_to word, "/post/hashtag/" + delete_pound_word
      else
        word
      end
    end
  end
end
