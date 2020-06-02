function [info] = tradeopps_page(info)

[info] = write_tradeopps_json(info);
[info] = write_tradeopps_js(info);
[info] = write_tradeopps_php(info);

end