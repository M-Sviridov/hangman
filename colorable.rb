# frozen_string_literal: true

# module to color strings font and background using the nord theme palette
module Colorable
  RGB_COLOR_MAP = {
    aurora1: '191;97;106',
    aurora2: '208;135;112',
    aurora3: '235;203;139',
    aurora4: '163;190;140',
    aurora5: '180;142;173',
    polar_night1: '46;52;64',
    polar_night2: '59;66;82',
    polar_night3: '67;76;94',
    polar_night4: '76;86;106',
    snow_storm1: '216;222;233',
    snow_storm2: '229;233;240',
    snow_storm3: '236;239;244',
    frost1: '143;188;187',
    frost2: '136;192;208',
    frost3: '129;161;193',
    frost4: '94;129;172'
  }.freeze

  refine String do
    def fg_color(color_name)
      rgb_val = RGB_COLOR_MAP[color_name]
      "\e[38;2;#{rgb_val}m#{self}\e[0m"
    end

    def bg_color(color_name)
      rgb_val = RGB_COLOR_MAP[color_name]
      "\e[48;2;#{rgb_val}m#{self}\e[0m"
    end
  end
end
