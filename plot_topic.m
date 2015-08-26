function plot_topic(x, y, y_legend, y_color, x_limit_len)

    x_min = min(x); x_max = max(x);
    x_index_min = 1; x_index_max = length(x);

    if length(x) >= x_limit_len
        x_index_min = x_index_max - x_limit_len + 1;
        x_avg_pitch = (max(x) - min(x)) / (length(x) - 1);
        x_min = x_max - x_avg_pitch * x_limit_len;
    end

    plot(x(x_index_min:end), y(x_index_min:end), y_color);
    xlim([x_min inf]);
    legend(y_legend);
end
