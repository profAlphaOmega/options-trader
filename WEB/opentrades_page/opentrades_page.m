function [info] = opentrades_page(info)


[info] = write_opentrades_json(info);
[info] = write_opentrades_js(info);
[info] = write_opentrades_php(info);

end