module SasuliHelpers
  def breadcrumb(full_path)
    /^(?<path>[^\/]*)/ =~ full_path
    %Q(<div class="title-breadcrumb">#{path}</div>)
  end

  def css(css_code)
    def line_case(html, service = '')
      unless service.empty?
        %Q(<span class="code-line" ng-if="selected == '#{service}'">#{html}</span><br ng-if="selected == '#{service}'">)
      else
        %Q(<span class="code-line">#{html}</span><br>)
      end
    end

    def equalize_height(sass, count)
      sass += line_case('') * count
    end

    def format_code(css, sass, scss)
      <<-EOS
        <div class="code-tabs">
          <span class="code-def code-tab" ng-class="{'code-tab-ing': ing == 'css'}" ng-click="$emit('ing', 'css')">CSS</span>
          <span class="code-def code-tab" ng-class="{'code-tab-ing': ing == 'sass'}" ng-click="$emit('ing', 'sass')">SASS</span>
          <span class="code-def code-tab" ng-class="{'code-tab-ing': ing == 'scss'}" ng-click="$emit('ing', 'scss')">SCSS</span>
        </div>
        <div class="code-mains">
          <div class="code-main" ng-if="ing == 'css'">#{css}</div>
          <div class="code-main" ng-if="ing == 'sass'">#{sass}</div>
          <div class="code-main" ng-if="ing == 'scss'">#{scss}</div>
        </div>
      EOS
      # <div class="code-def code-copy" copy-btn ng-mouseover="addFunc()" ng-mouseleave="removeFunc()">copy</div>
    end

    css_lines = css_code.split "\n"
    css = ''
    sass = ''
    sass_count = 0
    scss = ''

    css_lines.each do |l|
      case l
      when %r{^//}
        css += line_case %Q(<span class="code-def code-come">/* #{l.gsub(%r{//\s}, '')} */</span>)
        sass += line_case %Q(<span class="code-def code-come">#{l}</span>)
        scss += line_case %Q(<span class="code-def code-come">#{l}</span>)

      when /{/
        css += line_case('') unless css.empty?
        sass += line_case('') unless sass.empty?
        scss += line_case('') unless scss.empty?
        /^(?<selector>[^{]+)/ =~ l
        if /,/ =~ selector
          selectors = selector.split ', '
          len = selectors.size
          selectors.each_with_index do |s, i|
            s.gsub!(/(\s?\[hateblo\])/){ |c| /^\s/ =~ c ? %Q(<span ng-if="selected == 'hateblo'"> ) : %Q(<span ng-if="selected == 'hateblo'">) }
            s.gsub! /\[\/\]/, '</span>'
            unless i+1 == len
              css += line_case %Q(<span class="code-def code-selector" ng-cloak>{{selector}} #{s}</span>,)
              sass += line_case %Q(<span class="code-def code-selector" ng-cloak>{{selector}} #{s}</span>,)
              scss += line_case %Q(<span class="code-def code-selector" ng-cloak>{{selector}} #{s}</span>,)
            else
              css += line_case %Q(<span class="code-def code-selector" ng-cloak>{{selector}} #{s.rstrip}</span> {)
              sass += line_case %Q(<span class="code-def code-selector" ng-cloak>{{selector}} #{s.rstrip}</span>)
              scss += line_case %Q(<span class="code-def code-selector" ng-cloak>{{selector}} #{s.rstrip}</span> {)
            end
          end
        else
          selector.gsub!(/(\s?\[hateblo\])/){ |c| /^\s/ =~ c ? %Q(<span ng-if="selected == 'hateblo'"> ) : %Q(<span ng-if="selected == 'hateblo'">) }
          selector.gsub! /\[\/\]/, '</span>'
          if /@font-face/ =~ selector
            css += line_case %Q(<span class="code-def code-selector" ng-cloak>#{selector.rstrip}</span> {)
            sass += line_case %Q(<span class="code-def code-selector" ng-cloak>#{selector.rstrip}</span>)
            scss += line_case %Q(<span class="code-def code-selector" ng-cloak>#{selector.rstrip}</span> {)
          else
            css += line_case %Q(<span class="code-def code-selector" ng-cloak>{{selector}} #{selector.rstrip}</span> {)
            sass += line_case %Q(<span class="code-def code-selector" ng-cloak>{{selector}} #{selector.rstrip}</span>)
            scss += line_case %Q(<span class="code-def code-selector" ng-cloak>{{selector}} #{selector.rstrip}</span> {)
          end
        end
      when /:/
        /^(?<prop>[^:]+):(?<val>[^;]+)/ =~ l
        if /\[hateblo\]/ =~ l
          css += line_case %Q(  <span class="code-head code-def code-prop">#{prop.lstrip}</span>: <span class="code-def code-prop-val">#{val.lstrip}</span>;), 'hateblo'
          sass += line_case %Q(  <span class="code-head code-def code-prop">#{prop.lstrip}</span>: <span class="code-def code-prop-val">#{val.lstrip}</span>), 'hateblo'
          scss += line_case %Q(  <span class="code-head code-def code-prop">#{prop.lstrip}</span>: <span class="code-def code-prop-val">#{val.lstrip}</span>), 'hateblo'
        else
          css += line_case %Q(  <span class="code-head code-def code-prop">#{prop.lstrip}</span>: <span class="code-def code-prop-val">#{val.lstrip}</span>;)
          sass += line_case %Q(  <span class="code-head code-def code-prop">#{prop.lstrip}</span>: <span class="code-def code-prop-val">#{val.lstrip}</span>)
          scss += line_case %Q(  <span class="code-head code-def code-prop">#{prop.lstrip}</span>: <span class="code-def code-prop-val">#{val.lstrip}</span>)
        end

      when /}/
        css += line_case '}'
        scss += line_case '}'
        sass_count += 1
      end
    end
    format_code css, equalize_height(sass, sass_count), scss
  end
end