# Jekyll - Easy Youtube Embed
#
# Katie Harron - https://github.com/pibby
#
#   Input:
#     {% youtube Al9FOtZcadQ %}
#   Output:
#   <div class="video">
#     <figure>
#       <iframe width="640" height="480" src="//www.youtube.com/embed/Al9FOtZcadQ" allowfullscreen></iframe>
#     </figure>
#   </div>

module Jekyll
  class Youtube < Liquid::Tag
    @videoid = nil
    @width = ''
    @height = ''

    def initialize(tag_name, markup, tokens)
      super

      if markup =~ /(?:(?:https?:\/\/)?(?:www.youtube.com\/(?:embed\/|watch\?v=)|youtu.be\/)?(\S+)(?:\?rel=\d)?)(?:\s+(\d+)\s(\d+))?(?:\s+"(.*?)")?/i
        @videoid = $1
      end
    end

    def render(context)
      ouptut = super
      if @videoid
        # Thanks to Andrew Clark for the inline CSS calculation idea <http://contentioninvain.com/2013/02/13/video-embeds-for-responsive-designs/>
        intrinsic = ((@height.to_f / @width.to_f) * 100)
        padding_bottom = ("%.2f" % intrinsic).to_s  + "%"
        %Q{<div class="embed-responsive embed-responsive-16by9"><iframe src="//www.youtube-nocookie.com/embed/#{@videoid}?rel=0" frameborder="0" allowfullscreen></iframe></div>}
      end
    end
  end
end

Liquid::Template.register_tag('youtube', Jekyll::Youtube)