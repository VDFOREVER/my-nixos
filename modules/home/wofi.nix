{
	programs.wofi = {
        enable = true;
        settings = {
            height = 270;
            width = 450;

            no_actions = true;
            hide_scroll = true;

            image_size = 20;
            prompt = "search";
            term = "alacritty";
        };

        style = ''
*{
    font-family: JetBrainsMono;
    font-size: 13px;
}
@define-color bg #272a34;
@define-color fg #f9f9f9;
@define-color green #2be491;
@define-color gr #363749;
@define-color black #23252e;

window {
    background-color: @bg;
    border-radius: 6px;
    color: @bg;
}
#input {
    margin: 10 0 10 0x;
    padding: 1;
    border-radius: 5px;
    border: none;
    border-bottom: 0px solid @fg;
    background-color: @gr;
    color: @fg;
}
#inner-box {
    background-color: @bg;
    padding: 15 0 0 0;
}
#outer-box {
    margin: 20px;
    padding: 0px;
    background-color: @bg;
}
#text {
	padding: 8px;
	margin: 2px;
	color: @fg;
}
#entry {
	background-color: @bg;
	padding: 0 15px;
}
#entry:nth-child(even){
	background-color: @bg;
	padding: 0 15px;
}
#entry:selected {
	border-radius: 5px;
	background-color: @gr;
}
#text:selected {
	color: @fg;
}
        '';
	};
}
