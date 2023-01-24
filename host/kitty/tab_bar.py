from kitty.fast_data_types import Screen
# from kitty.rgb import Color
# from kitty.utils import color_as_int

from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_title


def draw_tab(
    draw_data: DrawData, screen: Screen, tab: TabBarData,
    before: int, max_title_length: int, index: int, is_last: bool,
    extra_data: ExtraData
) -> int:
    # Draw your own tab with `screen.draw()`, `screen.apply_sgr()`.
    # You can use the function `draw_title(draw_data, screen, tab, index)`.
    # Move the cursor by assigning the value to `screen.cursor.x`.
    # Set the color and style with `screen.cursor.fg: int, bg: int, bold: bool, italic: bool`.
    # Returns the position of the cursor after the tab has been drawn.
    screen.draw(" ")
    draw_title(draw_data, screen, tab, index)
    indicator = ""
    if tab.num_windows > 1:
        indicator = " ({})".format(tab.num_windows)
        if tab.layout_name == "stack":
            indicator = " (Z)"

    screen.draw(indicator)
    screen.draw(" ")
    end = screen.cursor.x
    return end
