%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  符合 GB/T 7714-2005 规范的 BibTeX 样式文件
%
%  作者：    胡海星   南京大学计算机科学与技术系
%  版本：    v2.1.1  2015年6月15日
%  项目主页: http://haixing-hu.github.io/nju-thesis/
%
%  参考资料:
%  [1] 中国国家标准化管理委员会. GB/T 7714-2005 文后参考文献着录规则[S]. 2005.
%  [2] PATASHNIK O. BiBTeXing[R/OL]. 1988[2013-08-27].
%      ftp://tug.ctan.org/pub/tex-archive/biblio/bibtex/contrib/doc/btxdoc.pdf
%  [3] PATASHNIK O. Designing BibTeX Styles[R/OL]. 1998[2013-08-27].
%      ftp://tug.ctan.org/pub/tex-archive/biblio/bibtex/contrib/doc/btxhak.pdf
%
%    This program is free software; you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation; either version 2 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License along
%    with this program; if not, write to the Free Software Foundation, Inc.,
%    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
ENTRY                                             % class Entry {
{                                                 % public:
  author                                          %   String author;
  editor                                          %   String editor;
  translator                                      %   String translator;
  title                                           %   String title;
  edition                                         %   String edition;
  address                                         %   String address;
  publisher                                       %   String publisher;
  pages                                           %   String pages;
  year                                            %   String year;
  date                                            %   String date;
  modifydate                                      %   String modifydate;
  citedate                                        %   String citedate;
  url                                             %   String url;
  doi                                             %   String doi;
  language                                        %   String language;
  booktitle                                       %   String booktitle;
  journal                                         %   String journal;
  chapter                                         %   String chapter;
  series                                          %   String series;
  volume                                          %   String volume;
  number                                          %   String number;
  version 										  %	  String version;
  month                                           %   String month;
  school                                          %   String school;
  institution                                     %   String institution;
  organization                                    %   String organization;
  type                                            %   String type;
  howpublished                                    %   String howpublished;
  eid                                             %   String eid;
  key                                             %   String key;
  country                                         %   String country;
  patentid                                        %   String patentid;
  media                                           %   String media;
} {                                               %   //  declare integer variables
  required                                        %   int required;  // withther the bibfield is required
} {                                               %   //  declare String variables
  label                                           %   String label;           //  label for the entry
  mark                                            %   String mark;            //  mark for the entry
                                                  %   //  there is ahidden entry variable sort.key$
                                                  %   String sort_key;
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
INTEGERS {                                        % //  declare global int variables
  entry.count                                     % static int entry_count;          // number of entries
  longest.label.width                             % static int longest_label_width;  // width of the longest label
  i                                               % static int i;
  j                                               % static int j;
  k                                               % static int k;
}                                                 %
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
STRINGS {                                         % //  declare global String variables
  longest.label                                   % static String longest_label;     //  the longest label
  s                                               % static String s;
  t                                               % static String t;
}                                                 %
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define global static constants
FUNCTION {true} 				{#1}
FUNCTION {false} 				{#0}
FUNCTION {debug.enabled} 		{true}
FUNCTION {cap.volume.en} 		{"Vol~"}
FUNCTION {cap.volume.zh} 		{"卷"}
FUNCTION {cap.edition.en} 		{"~ed"}
FUNCTION {cap.edition.zh} 		{"版"}
FUNCTION {cap.anonymous.en} 	{"Anon"}
FUNCTION {cap.anonymous.zh} 	{"佚名"}
FUNCTION {cap.no.address.en} 	{"[S.l.]"}
FUNCTION {cap.no.address.zh} 	{"[出版地不详]"}
FUNCTION {cap.no.publisher.en} 	{"[s.n.]"}
FUNCTION {cap.no.publisher.zh} 	{"[出版者不详]"}
FUNCTION {cap.et.al.en} 		{", et~al"}
FUNCTION {cap.et.al.zh} 		{", 等"}
FUNCTION {cap.translate.en} 	{"~trans"}
FUNCTION {cap.translate.zh} 	{"译"}
FUNCTION {cap.doi.url} 			{"http://dx.doi.org/"}
FUNCTION {cap.st.en} 			{"st"}
FUNCTION {cap.nd.en} 			{"nd"}
FUNCTION {cap.rd.en} 			{"rd"}
FUNCTION {cap.th.en} 			{"th"}

FUNCTION {cap.space}      {" "}
FUNCTION {cap.period} 		{"\@. "}
FUNCTION {cap.comma} 			{"\@, "}
FUNCTION {cap.colon} 			{"\thinspace{}\textnormal{: }"}
FUNCTION {cap.double.slash} 	{" //\thinspace{}"}
FUNCTION {cap.dash} 			{"\thinspace{}\textnormal{--}\thinspace{}"}

% Predefined latex command used to format the style of bibitems
FUNCTION {env.bibbegin} 		{ "\begin{thebibliography}" }
FUNCTION {env.bibend}   		{ "\end{thebibliography}" }
FUNCTION {cmd.bibauthor} 		{ "\providecommand{\bibauthor}[1]{#1}" }
FUNCTION {cmd.bibeditor} 		{ "\providecommand{\bibeditor}[1]{#1}" }
FUNCTION {cmd.bibtranslator} 	{ "\providecommand{\bibtranslator}[1]{#1}" }
FUNCTION {cmd.bibtitle} 		{ "\providecommand{\bibtitle}[1]{#1}" }
FUNCTION {cmd.bibbooktitle} 	{ "\providecommand{\bibbooktitle}[1]{#1}" }
FUNCTION {cmd.bibjournal} 		{ "\providecommand{\bibjournal}[1]{#1}" }
FUNCTION {cmd.bibmark} 			{ "\providecommand{\bibmark}[1]{#1}" }
FUNCTION {cmd.bibcountry} 		{ "\providecommand{\bibcountry}[1]{#1}" }
FUNCTION {cmd.bibpatentid} 		{ "\providecommand{\bibpatentid}[1]{#1}" }
FUNCTION {cmd.bibedition} 		{ "\providecommand{\bibedition}[1]{#1}" }
FUNCTION {cmd.biborganization} 	{ "\providecommand{\biborganization}[1]{#1}" }
FUNCTION {cmd.bibaddress} 		{ "\providecommand{\bibaddress}[1]{#1}" }
FUNCTION {cmd.bibpublisher} 	{ "\providecommand{\bibpublisher}[1]{#1}" }
FUNCTION {cmd.bibinstitution}	{ "\providecommand{\bibinstitution}[1]{#1}" }
FUNCTION {cmd.bibschool} 		{ "\providecommand{\bibschool}[1]{#1}" }
FUNCTION {cmd.bibvolume} 		{ "\providecommand{\bibvolume}[1]{#1}" }
FUNCTION {cmd.bibnumber} 		{ "\providecommand{\bibnumber}[1]{#1}" }
FUNCTION {cmd.bibversion} 		{ "\providecommand{\bibversion}[1]{#1}" }
FUNCTION {cmd.bibpages} 		{ "\providecommand{\bibpages}[1]{#1}" }
FUNCTION {cmd.bibmodifydate}	{ "\providecommand{\bibmodifydate}[1]{#1}" }
FUNCTION {cmd.bibcitedate} 		{ "\providecommand{\bibcitedate}[1]{#1}" }
FUNCTION {cmd.bibyear} 			{ "\providecommand{\bibyear}[1]{#1}" }
FUNCTION {cmd.bibdate} 			{ "\providecommand{\bibdate}[1]{#1}" }
FUNCTION {cmd.biburl} 			{ "\providecommand{\biburl}[1]{\newline\url{#1}}" }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {log.str} {                              % void Entry::log_str(String value, String message)
  debug.enabled {                                 %   if (debug_enabled == 1) {
    "DEBUG: " swap$ * " - '" *                    %     message = "DEBUG: " + message + " - '";
    swap$ *                                       %     message = message + value;
    "'" *                                         %     message = message + "'";
    top$                                          %     log(message);
  } {                                             %   } else {
    pop$ pop$                                     %     return;
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {log.int} {                              % int Entry::log_int(int value, String message)
  debug.enabled {                                 %   if (debug_enabled == 1) {
    "DEBUG: " swap$ * " - " *                     %     message = "DEBUG: " + message + " - ";
    swap$ int.to.str$ *                           %     message = message + int_to_str(value);
    top$                                          %     log(message);
  } {                                             %   } else {
    pop$ pop$                                     %     return;
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {not} {                                  % int Entry::not(int x) {
  {                                               %   if (x == 1) {
    false                                         %     return false;
  } {                                             %   } else {
    true                                          %     return true;
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {and} {                                  % int Entry::and(int x, int y) {
  {                                               %   if (y == 1) {
    skip$                                         %     return x;
  } {                                             %   } else {
    pop$ false                                    %     return false;
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {or} {                                   % int Entry::or(int x, int y) {
  {                                               %   if (y == 1) {
    pop$ true                                     %     return true;
  } {                                             %   } else {
    skip$                                         %     return x;
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  % //  calculate the length in characters of a string
                                                  % //  We need this function since text.length$ is NOT
                                                  % //  the length in characters.
INTEGERS {length.i}                               % static int length_i;
FUNCTION {length} {                               % int Entry::length(String str) {
  duplicate$ empty$ {                             %   if (empty(str)) {
    pop$ #0                                       %     return 0;
  } {                                             %   } else {
    #1 'length.i :=                               %     length_i = 1;
    false                                         %     int stop = false;
    {not} {                                       %     while (! stop) {
      duplicate$ length.i #1 substring$           %       String tmp = substring(str, length_i, 1);
      "" = {                                      %       if (tmp == "") {
        true                                      %         stop = true;
      } {                                         %       } else {
        length.i #1 + 'length.i :=                %         length_i = length_i + 1;
        false                                     %         stop = false;
      } if$                                       %       }
    } while$                                      %     }
    pop$ length.i #1 -                            %     return length_i - 1;
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {is.digit} {                             % int Entry::is_digit(String ch) {
  chr.to.int$                                     %   int ascii = chr_to_int(ch);
  duplicate$ "0" chr.to.int$ < {                  %   if (ascii < chr_to_int("0")) {
    pop$ false                                    %     return false;
  } {                                             %   } else {
    "9" chr.to.int$ > {                           %     if (ascii > chr_to_int("9")) {
      false                                       %       return false;
    } {                                           %     } else {
      true                                        %       return true;
    } if$                                         %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  % // test if str is a number
FUNCTION {is.number} {                            % int Entry::is_number(String str) {
  duplicate$ empty$ not swap$                     %   int result = (! empty(str));
  { duplicate$ empty$ not} {                      %   while (! empty(str)) {
    duplicate$ #1 #1 substring$ is.digit {        %     if (is_digit(substring(str, 1, 1))) {
      #2 global.max$ substring$                   %       str = substring(str, 2, global_max);
    } {                                           %     } else {
      pop$ pop$ false                             %       result = false;
      ""                                          %       str = "";
    } if$                                         %     }
  } while$                                        %   }
  pop$                                            %   return result;
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  % // extract the number prefix of str
FUNCTION {extract.number} {                       % String Entry::extract_number(String str) {
  duplicate$                                      %   String suffix = str;
  duplicate$ length swap$                         %   int n = length(str);
  duplicate$ empty$                               %   int stop = empty(suffix);
  { not } {                                       %   while (! stop) {
    duplicate$ #1 #1 substring$ is.digit {        %     if (is_digit(substring(suffix, 1, 1))) {
      #2 global.max$ substring$                   %       suffix = substring(suffix, 2, global_max);
      duplicate$ empty$                           %       stop = empty(suffix);
    } {                                           %     } else {
      true                                        %       stop = true;
    } if$                                         %     }
  } while$                                        %   }
  length -                                        %   int n = n - length(suffix);
  #1 swap$ substring$                             %   return substring(str, 1, n);
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {get.last.chr} {                         % String Entry::get_last_chr(String str) {
  duplicate$ length                               %   int n = length(str);
  duplicate$ #0 = {                               %   if (n == 0) {
    pop$                                          %     return str;
  } {                                             %   } else {
    #1 substring$                                 %     return substring(str, n, 1);
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {get.ordinal.suffix.en} {                % String Entry::get_ordinal_suffix_en(String ch) {
  duplicate$ "1" = {                              %   if (num == "1") {
    pop$ cap.st.en                                %     return cap_st_en;
  } {                                             %   } else {
    duplicate$ "2" = {                            %     if (num == "2") {
      pop$ cap.nd.en                              %       return cap_nd_en;
    } {                                           %     } else {
      duplicate$ "3" = {                          %       if (num == "3") {
        pop$ cap.rd.en                            %         return cap_rd_en;
      } {                                         %       } else {
        pop$ cap.th.en                            %         return cap_th_en;
      } if$                                       %       }
    } if$                                         %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {num.to.ordinal.en} {                    % String Entry::num_to_ordinal_en(String num) {
  duplicate$ empty$ {                             %   if (empty(num)) {
    skip$                                         %     return num;
  } {                                             %   } else {
    duplicate$ get.last.chr                       %     String ch = get_last_chr(num);
    get.ordinal.suffix.en                         %     String str = get_ordinal_suffix_en(ch);
    *                                             %     reutrn num + str;
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
STRINGS {remove.dots.result}                      % static String remove_dots_result;
                                                  %
FUNCTION {remove.dots} {                          % String Entry::remove_dots(String str) {
  "" 'remove.dots.result :=                       %   remove_dots_result = "";
  { duplicate$ empty$ not } {                     %   while (! empty(str)) {
    duplicate$ #1 #2 substring$                   %     String tmp = substring(str, 1, 2);
    "\." = {                                      %     if (tmp == "\.") {
      #3 global.max$ substring$                   %       str = substring(str, 3, global_max);
    } {                                           %     } else {
      duplicate$ #1 #1 substring$                 %       tmp = substring(str, 1, 1);
      duplicate$ "." = {                          %       if (tmp == ".") {
        pop$ #2 global.max$ substring$            %         str = substring(str, 2, global_max);
      } {                                         %       } else {
        remove.dots.result swap$ *                %         tmp = remove_dots_result + tmp;
        'remove.dots.result :=                    %         remove_dots_result = tmp;
        #2 global.max$ substring$                 %         str = substring(str, 2, global_max);
      } if$                                       %       }
    } if$                                         %     }
  } while$                                        %   }
  pop$ remove.dots.result                         %   return remove_dots_result;
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {add.brace} {                            % String Entry::add_brace(String str) {
  "{" swap$ * "}" *                               %   return "{" + str + "}";
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {add.bracket} {                          % String Entry::bracket(String str) {
  "(" swap$ * ")" *                               %   return "(" + str + ")";
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {add.squarebracket} {                    % String Entry::add_squarebracket(String str) {
  "[" swap$ * "]" *                               %   return "[" + str + "]";
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {add.textit} {                           % String Entry::add_textit(String str) {
  "\textit{" swap$ * "}" *                        %   return "\textit{" + str + "}";
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {add.textbf} {                           % String Entry::add_textbf(String str) {
  "\textbf{" swap$ * "}" *                        %   return "\textbf{" + str + "}";
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  % // test if str contains a dash '-'
FUNCTION {contain.dash} {                         % int Entry::contain_dash(String str) {
  false swap$                                     %   int result = false;
  { duplicate$ empty$ not} {                      %   while (! empty(str)) {
    duplicate$ #1 #1 substring$ "-" = {           %     if (substring(str, 1, 1) == "-") {
      pop$ pop$ true                              %       result = true;
      ""                                          %       str = "";
    } {                                           %     } else {
      #2 global.max$ substring$                   %       str = substring(str, 2, global_max);
    } if$                                         %     }
  } while$                                        %   }
  pop$                                            %   return result;
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  % // extract the substring before the first '-'
                                                  % // returns the string itself if no '-'
FUNCTION {extract.before.first.dash} {            % String Entry::extract_before_first_dash(String str) {
  duplicate$                                      %   String suffix = str;
  duplicate$ length swap$                         %   int n = length(str);
  duplicate$ empty$                               %   int stop = empty(suffix);
  { not } {                                       %   while (! stop) {
    duplicate$ #1 #1 substring$ "-" = {           %     if (substring(suffix, 1, 1) == "-") {
      true                                        %       stop = true;
    } {                                           %     } else {4r
      #2 global.max$ substring$                   %       suffix = substring(suffix, 2, global_max);
      duplicate$ empty$                           %       stop = empty(suffix);
    } if$                                         %     }
  } while$                                        %   }
  length -                                        %   int n = n - length(suffix);
  #1 swap$ substring$                             %   return substring(str, 1, n);
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  % // extract the substring after the first '-'
                                                  % // returns the string itself if no '-'
FUNCTION {extract.after.first.dash} {             % String Entry::extract_after_first_dash(String str) {
  duplicate$                                      %   String suffix = str;
  duplicate$ empty$                               %   int stop = empty(suffix);
  { not } {                                       %   while (! stop) {
    duplicate$ #1 #1 substring$ "-" = {           %     if (substring(suffix, 1, 1) == "-") {
      true                                        %       stop = true;
    } {                                           %     } else {4r
      #2 global.max$ substring$                   %       suffix = substring(suffix, 2, global_max);
      duplicate$ empty$                           %       stop = empty(suffix);
    } if$                                         %     }
  } while$                                        %   }
  duplicate$ empty$ {                             %   if (empty(suffix)) {
    pop$                                          %     return str;
  } {                                             %   } else {
    swap$ pop$ #2 global.max$ substring$          %     return substring(suffix, 2, global_max);
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  % // extract the substring after the last '-'
                                                  % // returns the empty string if no '-'
FUNCTION {extract.after.last.dash} {              % String Entry::extract_after_last_dash(String str) {
  duplicate$ contain.dash not {                   %   if (! contain_dash(str)) {
    pop$ ""                                       %     return "";
  } {                                             %   } else {
    {duplicate$ contain.dash} {                   %     while (contain_dash(str)) {
      extract.after.first.dash                    %       str = extract_after_first_dash(str);
    } while$                                      %     }
                                                  %     return str;
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {trim.start} {                           % String Entry::trim_start(String str) {
  {duplicate$ #1 #1 substring$ " " =} {           %   while (substring(str, 1, 1) == " ") {
    #2 global.max$ substring$                     %     str = substring(str, 2, global_max);
  } while$                                        %   }
                                                  %   return str;
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {trim.end} {                             % String Entry::trim_end(String str) {
  {duplicate$ get.last.chr " " =} {               %   while (get_last_chr(str) == " ") {
    duplicate$ length #1 -                        %     int n = length(str) - 1;
    #1 swap$ substring$                           %     str = substring(str, 1, n);
  } while$                                        %   }
                                                  %   return str;
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {trim} {                                 % String Entry::trim(String str) {
  trim.start                                      %   str = trim_start(str);
  trim.end                                        %   return trim_end(str);
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {start.bibitem} {                        % void Entry::start_bibitem() {
  newline$                                        %   writeln();
  "\bibitem{" cite$ * "}" * write$                %   write("\bibitem{" + this.cite + "}");
  newline$                                        %   writeln();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {end.bibitem} {                          % void Entry::end_bibitem() {
  cap.period write$                               %   write(cap_period);
  newline$                                        %   writeln();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {is.in.chinese} {                        % int Entry::is_in_chinese() {
  language empty$ {                               %   if (empty(this.language)) {
    false                                         %     return false;
  } {                                             %   } else {
    language "zh" = {                             %     if (this.language == "zh") {
      true                                        %       return true;
    } {                                           %     } else {
      false                                       %       return false;
    } if$                                         %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {is.online} {                            % int Entry::is_online() {
  url empty$ not {                                %   if (! empty(this.url)) {
    true                                          %     return true;
  } {                                             %   } else {
    doi empty$ not {                              %     if (! empty(this.doi)) {
      true                                        %       return true;
    } {                                           %     } else {
      false                                       %       return false;
    } if$                                         %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {set.mark} {                             % void Entry::set_mark(String mark) {
  'mark :=                                        %   this.mark = mark;
  is.online {                                     %   if (is_online()) {
    mark "/OL" * 'mark :=                         %     this.mark = this.mark + "/OL";
  } {                                             %   } else {
    media empty$ not {                            %     if (! empty(this.media)) {
      mark "/" * media * 'mark :=                 %       this.mark = this.mark + "/" + this.media;
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {cap.volume} {                           % String Entry::cap_volume() {
  is.in.chinese {                                 %   if (is_in_chinese()) {
    cap.volume.zh                                 %     return cap_volume_zh;
  } {                                             %   } else {
    cap.volume.en                                 %     return cap_volume_en;
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {cap.edition} {                          % String Entry::cap_edition() {
  is.in.chinese {                                 %   if (is_in_chinese()) {
    cap.edition.zh                                %     return cap_edition_zh;
  } {                                             %   } else {
    cap.edition.en                                %     return cap_edition_en;
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {cap.anonymous} {                        % String Entry::cap_anonymous() {
  is.in.chinese {                                 %   if (is_in_chinese()) {
    cap.anonymous.zh                              %     return cap_anonymous_zh;
  } {                                             %   } else {
    cap.anonymous.en                              %     return cap_anonymous_en;
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {cap.no.address} {                       % String Entry::cap_no_address() {
  is.in.chinese {                                 %   if (is_in_chinese()) {
    cap.no.address.zh                             %     return cap_no_address_zh;
  } {                                             %   } else {
    cap.no.address.en                             %     return cap_no_address_en;
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {cap.no.publisher} {                     % String Entry::cap_no_publisher() {
  is.in.chinese {                                 %   if (is_in_chinese()) {
    cap.no.publisher.zh                           %     return cap_no_publisher_zh;
  } {                                             %   } else {
    cap.no.publisher.en                           %     return cap_no_publisher_en;
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {cap.et.al} {                            % String Entry::cap_et_al() {
  is.in.chinese {                                 %   if (is_in_chinese()) {
    cap.et.al.zh                                  %     return cap_et_al_zh;
  } {                                             %   } else {
    cap.et.al.en                                  %     return cap_et_al_en;
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {cap.translate} {                        % String Entry::cap_translate() {
  is.in.chinese {                                 %   if (is_in_chinese()) {
    cap.translate.zh                              %     return cap_translate_zh;
  } {                                             %   } else {
    cap.translate.en                              %     return cap_translate_en;
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.bibinfo} {                       % String Entry::format_bibinfo(String info, String type) {
  swap$ add.brace swap$                           %   info = add_brace(info);
  "\bib" swap$ * swap$ *                          %   return "\bib" + type + info;
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
INTEGERS { nameindex namecount }                  % static int nameindex, namecount;
STRINGS  { namelist nameformat }                  % static String namelist, nameformat;
STRINGS  { firstname lastname jrname vonname}     % static String firstname, lastname, jrname, vonname;
                                                  %
FUNCTION {format.names} {                         % String Entry::format_names(String names) {
  'namelist :=                                    %   namelist = names;
  namelist num.names$ 'namecount :=               %   namecount = num_names(namelist);
  ""                                              %   String result = "";
  #0 'nameindex :=                                %   nameindex = 0;
  {nameindex namecount < nameindex #3 < and} {    %   while ((nameindex < namecount) && (nameindex < 3)) {
    nameindex #1 + 'nameindex :=                  %     nameindex = nameindex + 1;
    nameindex #1 > {                              %     if (nameindex > 1) {
      cap.comma *                                 %       result = result + cap_comma;
    } 'skip$ if$                                  %     }
    namelist nameindex "{vv}" format.name$        %     String tmp = format_name(namelist, nameindex, "{vv}");
   'vonname :=                                    %     vonname = tmp;
    namelist nameindex "{jj}" format.name$        %     tmp = format_name(namelist, nameindex, "{jj}");
    remove.dots 'jrname :=                        %     jrname = remove_dots(tmp);
    namelist nameindex "{f}" format.name$         %     tmp = format_name(namelist, nameindex, "{f}");
    remove.dots                                   %     tmp = remove_dots(tmp);
    "u" change.case$ 'firstname :=                %     firstname = change_case(tmp, "u");
    namelist nameindex "{ll}" format.name$        %     tmp = format_name(namelist, nameindex, "{ll}");
    "u" change.case$ 'lastname :=                 %     lastname = change_case(tmp, "u");
    jrname empty$ not {                           %     if (! empty(jrname)) {
      jrname * " " *                              %       result = result + jrname + " "
    } 'skip$ if$                                  %     }
    vonname empty$ not {                          %     if (! empty(vonname)) {
      vonname * " " *                             %       result = result + vonname + " "
    } 'skip$ if$                                  %     }
    lastname empty$ not {                         %     if (! empty(lastname)) {
      lastname * " " *                            %       result = result + lastname + " "
    } 'skip$ if$                                  %     }
    firstname empty$ not {                        %     if (! empty(firstname)) {
      firstname * " " *                           %       result = result + firstname + " "
    } 'skip$ if$                                  %     }
    trim.end                                      %     result = trim_end(result);
  } while$                                        %   }
  nameindex namecount < {                         %   if (nameindex < namecount) {
    cap.et.al *                                   %     result = result + cap_et_al();
  } 'skip$ if$                                    %   }
}                                                 % }
                                                  %
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  % // format English names
FUNCTION {format.names.en} {                      % String Entry::format_names_en(String names) {
  format.names                                    %   format_names(names);
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  % // format Chinese names
FUNCTION {format.names.zh} {                      % String Entry::format_names_zh(String names) {
  format.names                                    %   format_names(names);
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.author} {                        % String Emtry::format_author(String authors) {
  is.in.chinese {                                 %   if (is_in_chinese) {
    format.names.zh                               %     authors = format_names_zh(authors);
  } {                                             %   } else {
    format.names.en                               %     authors = format_names_en(authors);
  } if$                                           %   }
  "author" format.bibinfo                         %   return format_bibinfo(authors, "author");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.editor} {                        % String Emtry::format_author(String editors) {
  is.in.chinese {                                 %   if (is_in_chinese) {
    format.names.zh                               %     editors = format_names_zh(editors);
  } {                                             %   } else {
    format.names.en                               %     editors = format_names_en(editors);
  } if$                                           %   }
  "editor" format.bibinfo                         %   return format_bibinfo(editors, "editor");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.translator} {                    % String Emtry::format_translator(String translators) {
  is.in.chinese {                                 %   if (is_in_chinese) {
    duplicate$                                    %     String names = translators;
    format.names.zh                               %     translators = format_names_zh(translators);
    swap$ num.names$ #3 > {                       %     if (num_names(names) > 3) {
      cap.translate.zh *                          %       translators = translators + cap_translate_zh;
    } {                                           %     } else {
      cap.comma * cap.translate.zh *              %       translators = translators + cap_comma + cap_translate_zh;
    } if$                                         %     }
  } {                                             %   } else {
    duplicate$                                    %     String names = translators;
    format.names.en                               %     translators = format_names_en(translators);
    swap$ num.names$ #3 > {                       %     if (num_names(names) > 3) {
      cap.translate.en *                          %       translators = translators + cap_translate_en;
    } {                                           %     } else {
      cap.comma * cap.translate.en *              %       translators = translators + cap_comma + cap_translate_en;
    } if$                                         %     }
  } if$                                           %   }
  "translator" format.bibinfo                     %   return format_bibinfo(translator, "translator");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.title} {                         % String Emtry::format_title(String title) {
  "title" format.bibinfo                          %   return format_bibinfo(title, "title");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.booktitle} {                     % String Emtry::format_booktitle(String booktitle) {
  "booktitle" format.bibinfo                      %   return format_bibinfo(booktitle, "booktitle");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.mark} {                          % String Emtry::format_mark(String mark) {
  "[" swap$ * "]" *                               %   mark = "[" + mark + "]";
  "mark" format.bibinfo                           %   return format_bibinfo(mark, "mark");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.country} {                       % String Emtry::format_country(String country) {
  "country" format.bibinfo                        %   return format_bibinfo(country, "country");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.patentid} {                      % String Emtry::format_patentid(String patentid) {
  "patentid" format.bibinfo                       %   return format_bibinfo(patentid, "patentid");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.edition} {                       % String Emtry::format_edition(String edition) {
  duplicate$ is.number {                          %   if (is_number(edition)) {
    is.in.chinese {                               %     if (is_in_chinese()) {
      cap.edition.zh *                            %       edition = edition + cap_edition_zh;
    } {                                           %     } else {
      num.to.ordinal.en cap.edition.en *          %       edition = num_to_ordinal_en(edition) + cap_edition_en;
    } if$                                         %     }
  } 'skip$ if$                                    %   }
                                                  %   //  use a \mbox{} to prevent line break within edition
  "\mbox{" swap$ * "}" *                          %   edition = "\mbox{" + edition + "}";
  "edition" format.bibinfo                        %   return format_bibinfo(edition, "edition");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.organization} {                  % String Emtry::format_organization(String organization) {
  "organization" format.bibinfo                   %   return format_bibinfo(organization, "organization");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.address} {                       % String Emtry::format_address(String address) {
  "address" format.bibinfo                        %   return format_bibinfo(address, "address");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.publisher} {                     % String Emtry::format_publisher(String publisher) {
  "publisher" format.bibinfo                      %   return format_bibinfo(publisher, "publisher");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.institution} {                   % String Emtry::format_institution(String institution) {
  "institution" format.bibinfo                    %   return format_bibinfo(institution, "institution");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.school} {                        % String Emtry::format_school(String school) {
  "school" format.bibinfo                         %   return format_bibinfo(school, "school");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.year} {                          % String Emtry::format_year(String year) {
  "year" format.bibinfo                           %   return format_bibinfo(year, "year");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.date} {                          % String Emtry::format_date(String date) {
  "date" format.bibinfo                           %   return format_bibinfo(date, "date");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.journal} {                       % String Emtry::format_journal(String journal) {
  "journal" format.bibinfo                        %   return format_bibinfo(journal, "journal");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.volume} {                        % String Emtry::format_volume(String volume) {
  "volume" format.bibinfo                         %   return format_bibinfo(volume, "volume");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.number} {                        % String Emtry::format_number(String number) {
  add.bracket                                     %   number = add_bracket(number);
  "number" format.bibinfo                         %   return format_bibinfo(number, "number");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.report.number} {                 % String Emtry::format_report_number(String number) {
  "number" format.bibinfo                         %   return format_bibinfo(number, "number");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.version} {                       % String Emtry::format_version(String version) {
  "version" format.bibinfo                        %   return format_bibinfo(version, "version");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.pages} {                         % String Emtry::format_pages(String pages) {
  "pages" format.bibinfo                          %   return format_bibinfo(pages, "pages");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.modifydate} {                    % String Emtry::format_modifydate(String modifydate) {
  add.bracket                                     %   modifydate = add_bracket(modifydate);
  "modifydate" format.bibinfo                     %   return format_bibinfo(modifydate, "modifydate");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {format.citedate} {                      % String Emtry::format_citedate(String citedate) {
  add.squarebracket                               %   citedate = add_squarebracket(citedate);
  "citedate" format.bibinfo                       %   return format_bibinfo(citedate, "citedate");
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
                                                  % // NOTE: do not use the format_bibinfo() for URL,
                                                  % // since if the URL contains special symbols such
                                                  % // as '%', the \biburl{} will be broken.
FUNCTION {format.url} {                           % String Emtry::format_url(String url) {
  "\newline\url{" swap$ * "}" *                   %   return "\newline\url{" + url + "}";
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {get.full.title} {                       % String Entry::get_full_title() {
  series empty$ {                                 %     if (empty(this.series)) {
    volume empty$ {                               %       if (empty(this.volume)) {
      title                                       %         return this.title;
    } {                                           %       } else {
      title cap.colon * cap.volume * volume *     %         return this.title + cap_colon + cap_volume() + this.volume;
    } if$                                         %       }
  } {                                             %     } else {
    volume empty$ {                               %       if (empty(this.volume)) {
      series cap.colon * title *                  %         return this.series + cap_colon + this.title;
    } {                                           %       } else {
      series cap.comma * cap.volume * volume *    %         String str = this.series + cap_comma + cal_volume() + this.volume;
      cap.colon * title *                         %         return str + cap_colon + this.title;
    } if$                                         %       }
  } if$                                           %     }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {get.full.booktitle} {                   % String Entry::get_full_booktitle() {
  series empty$ {                                 %     if (empty(this.series)) {
    volume empty$ {                               %       if (empty(this.volume)) {
      booktitle                                   %         return this.booktitle;
    } {                                           %       } else {
      booktitle cap.colon * cap.volume * volume * %         return this.booktitle + cap_colon + cap_volume() + this.volume;
    } if$                                         %       }
  } {                                             %     } else {
    volume empty$ {                               %       if (empty(this.volume)) {
      series cap.colon * booktitle *              %         return this.series + cap_colon + this.booktitle;
    } {                                           %       } else {
      series cap.comma * cap.volume * volume *    %         String str = this.series + cap_comma + cal_volume() + this.volume;
      cap.colon * booktitle *                     %         return str + cap_colon + this.booktitle;
    } if$                                         %       }
  } if$                                           %     }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {get.pages} {                            % String Entry::get_pages() {
  pages contain.dash {                            %   if (contain_dash(this.pages)) {
    pages extract.before.first.dash               %     String p1 = extract_before_first_dash(this.pages);
    pages extract.after.last.dash                 %     String p2 = extract_after_last_dash(this.pages);
    cap.dash swap$ * *                            %     return p1 + cap_dash + p2;
  } {                                             %   } else {
    pages                                         %     return this.pages;
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.author.or.editor} {              % void Entry::output_author_or_editor(int required) {
  'required :=                                    %   this.required = required;
  author empty$ not {                             %   if (! empty(this.author)) {
    author format.author write$                   %     write(format_author(this.author));
    cap.period write$                             %     write(cap_period);
  } {                                             %   } else {
    editor empty$ not {                           %     if (! empty(this.editor)) {
      editor format.editor write$                 %       write(format_editor(this.editor));
      cap.period write$                           %       write(cap_period);
    } {                                           %     } else {
      required {                                  %       if (required == 1) {
        "Require author/editor: " cite$ * warning$%         warning("Require author/editor: " + this.cite);
        cap.anonymous format.author write$        %         write(format_author(cap_anonymous()));
        cap.period write$                         %         write(cap_period);
      } 'skip$ if$                                %       }
    } if$                                         %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.author} {                        % void Entry::output_author(int required) {
  'required :=                                    %   this.required = required;
  author empty$ not {                             %   if (! empty(this.author)) {
    author format.author write$                   %     write(format_author(this.author));
    cap.period write$                             %     write(cap_period);
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require author: " cite$ * warning$         %       warning("Require author: " + this.cite);
      cap.anonymous format.author write$          %       write(format_author(cap_anonymous()));
      cap.period write$                           %       write(cap_period);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.editor} {                        % void Entry::output_editor(int required) {
  'required :=                                    %   this.required = required;
  editor empty$ not {                             %   if (! empty(this.editor)) {
    editor format.editor write$                   %     write(format_editor(this.editor));
    cap.period write$                             %     write(cap_period);
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require editor: " cite$ * warning$         %       warning("Require editor: " + this.cite);
      cap.anonymous format.editor write$          %       write(format_editor(cap_anonymous()));
      cap.period write$                           %       write(cap_period);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.title} {                         % void Entry::output_title(int required) {
  'required :=                                    %   this.required = required;
  title empty$ not {                              %   if (! empty(this.title)) {
    title format.title write$                     %     write(format_title(this.title));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require title: " cite$ * warning$          %       warning("Require title: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.series.volume.title} {           % void Entry::output_series_volume_title(int required) {
  'required :=                                    %   this.required = required;
  title empty$ not {                              %   if (! empty(this.title)) {
    get.full.title format.booktitle write$        %     write(format_booktitle(get_full_title()));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require title: " cite$ * warning$          %       warning("Require title: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.series.volume.booktitle} {       % void Entry::output_series_volume_booktitle(int required) {
  'required :=                                    %   this.required = required;
  booktitle empty$ not {                          %   if (! empty(this.booktitle)) {
    get.full.booktitle format.booktitle write$    %     write(format_booktitle(get_full_booktitle());
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require booktitle: " cite$ * warning$      %       warning("Require booktitle: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.journal} {                       % void Entry::output_journal(int required) {
  'required :=                                    %   this.required = required;
  journal empty$ not {                            %   if (! empty(this.journal)) {
    cap.period write$                             %     write(cap_period);
    journal format.journal write$                 %     write(format_journal(this.journal));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require journal: " cite$ * warning$        %       warning("Require journal: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.mark} {                          % void Entry::output_mark(int required) {
  'required :=                                    %   this.required = required;
  mark empty$ not {                               %   if (! empty(this.mark)) {
    mark format.mark write$                       %     write(format_mark(this.mark));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require mark: " cite$ * warning$           %       warning("Require mark: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.translator} {                    % void Entry::output_translator(int required) {
  'required :=                                    %   this.required = required;
  translator empty$ not {                         %   if (! empty(this.translator)) {
    cap.period write$                             %     write(cap_period);
    translator format.translator write$           %     write(format_translator(this.translator));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require translator: " cite$ * warning$     %       warning("Require translator: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.edition} {                       % void Entry::output_edition(int required) {
  'required :=                                    %   this.required = required;
  edition empty$ not {                            %   if (! empty(this.edition)) {
    cap.period write$                             %     write(cap_period);
    edition format.edition write$                 %     write(format_edition(this.edition));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require edition: " cite$ * warning$        %       warning("Require edition: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.address} {                       % void Entry::output_address(int required) {
  'required :=                                    %   this.required = required;
  address empty$ not {                            %   if (! empty(this.address)) {
    cap.period write$                             %     write(cap_period);
    address format.address write$                 %     write(format_address(this.address));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require address: " cite$ * warning$        %       warning("Require address: " + this.cite);
      cap.period write$                           %       write(cap_period);
      cap.no.address format.address write$        %       write(format_address(cap_no_address()));
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.publisher} {                     % void Entry::output_publisher(int required) {
  'required :=                                    %   this.required = required;
  publisher empty$ not {                          %   if (! empty(this.publisher)) {
    cap.colon write$                              %     write(cap_colon);
    publisher format.publisher write$             %     write(format_publisher(this.publisher));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require publisher: " cite$ * warning$      %       warning("Require publisher: " + this.cite);
      cap.colon write$                            %       write(cap_colon);
      cap.no.publisher format.publisher write$    %       write(format_publisher(cap_no_publisher()));
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.publisher.no.address} {          % void Entry::output_publisher_no_address(int required) {
  'required :=                                    %   this.required = required;
  publisher empty$ not {                          %   if (! empty(this.publisher)) {
    cap.period write$                             %     write(cap_period);
    publisher format.publisher write$             %     write(format_publisher(this.publisher));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require publisher: " cite$ * warning$      %       warning("Require publisher: " + this.cite);
      cap.period write$                           %       write(cap_period);
      cap.no.publisher format.publisher write$    %       write(format_publisher(cap_no_publisher()));
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.school} {                        % void Entry::output_school(int required) {
  'required :=                                    %   this.required = required;
  school empty$ not {                             %   if (! empty(this.school)) {
    cap.colon write$                              %     write(cap_colon);
    school format.school write$                   %     write(format_school(this.school));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require school: " cite$ * warning$         %       warning("Require publisher: " + this.cite);
      cap.colon write$                            %       write(cap_colon);
      cap.no.publisher format.school write$       %       write(format_school(cap_no_publisher()));
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.institution} {                   % void Entry::output_institution(int required) {
  'required :=                                    %   this.required = required;
  institution empty$ not {                        %   if (! empty(this.institution)) {
    cap.colon write$                              %     write(cap_colon);
    institution format.institution write$         %     write(format_publisher(this.institution));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require institution: " cite$ * warning$    %       warning("Require institution: " + this.cite);
      cap.colon write$                            %       write(cap_colon);
      cap.no.publisher format.institution write$  %       write(format_institution(cap_no_publisher()));
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.year} {                          % void Entry::output_year(int required) {
  'required :=                                    %   this.required = required;
  year empty$ not {                               %   if (! empty(this.year)) {
    year format.year write$                       %     write(format_year(this.year));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require year: " cite$ * warning$           %       warning("Require year: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.pages} {                         % void Entry::output_pages(int required) {
  'required :=                                    %   this.required = required;
  pages empty$ not {                              %   if (! empty(this.pages)) {
    cap.colon write$                              %     write(cap_colon);
    get.pages format.pages write$                 %     write(format_pages(get_pages()));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require pages: " cite$ * warning$          %       warning("Require pages: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.modifydate} {                    % void Entry::output_modifydate(int required) {
  'required :=                                    %   this.required = required;
  modifydate empty$ not {                         %   if (! empty(this.modifydate)) {
    cap.space write$                              %     write(cap_space);
    modifydate format.modifydate write$           %     write(format_modifydate(this.modifydate));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require modifydate: " cite$ * warning$     %       warning("Require modifydate: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.citedate} {                      % void Entry::output_citedate(int required) {
  'required :=                                    %   this.required = required;
  citedate empty$ not {                           %   if (! empty(this.citedate)) {
    cap.space write$                              %     write(cap_space);
    citedate format.citedate write$               %     write(format_citedate(this.citedate));
  } {                                             %   } else {
    required is.online or {                       %     if ((required == 1) || (is_online())) {
      "Require citedate: " cite$ * warning$       %       warning("Require citedate: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.date} {                          % void Entry::output_date(int required) {
  'required :=                                    %   this.required = required;
  date empty$ not {                               %   if (! empty(this.date)) {
    date format.date write$                       %     write(format_date(this.date));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require date: " cite$ * warning$           %       warning("Require date: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.volume} {                        % void Entry::output_volume(int required) {
  'required :=                                    %   this.required = required;
  volume empty$ not {                             %   if (! empty(this.volume)) {
    cap.comma write$                              %     write(cap_comma);
    volume format.volume write$                   %     write(format_volume(this.volume));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require volume: " cite$ * warning$         %       warning("Require volume: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.number} {                        % void Entry::output_number(int required) {
  'required :=                                    %   this.required = required;
  number empty$ not {                             %   if (! empty(this.number)) {
    number format.number write$                   %     write(format_number(this.number));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require number: " cite$ * warning$         %       warning("Require number: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.report.number} {                 % void Entry::output_report_number(int required) {
  'required :=                                    %   this.required = required;
  number empty$ not {                             %   if (! empty(this.number)) {
  	cap.colon write$                              %     write(cap_colon);
    number format.report.number write$            %     write(format_report_number(this.number));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require number: " cite$ * warning$         %       warning("Require number: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.country} {                       % void Entry::output_country(int required) {
  'required :=                                    %   this.required = required;
  country empty$ not {                            %   if (! empty(this.country)) {
    cap.colon write$                              %     write(cap_colon);
    country format.country write$                 %     write(format_country(this.country));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require country: " cite$ * warning$        %       warning("Require country: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.patentid} {                      % void Entry::output_patentid(int required) {
  'required :=                                    %   this.required = required;
  patentid empty$ not {                           %   if (! empty(this.patentid)) {
    cap.comma write$                              %     write(cap_comma);
    patentid format.patentid write$               %     write(format_patentid(this.patentid));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require patentid: " cite$ * warning$       %       warning("Require patentid: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.start.year} {                    % void Entry::output_start_year(int required) {
  'required :=                                    %   this.required = required;
  year empty$ not {                               %   if (! empty(this.year)) {
    year extract.before.first.dash                %     String str = extract_before_first_dash(this.year);
    format.year write$                            %     write(format_year(str));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require year: " cite$ * warning$           %       warning("Require year: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.start.volume} {                  % void Entry::output_start_volume(int required) {
  'required :=                                    %   this.required = required;
  volume empty$ not {                             %   if (! empty(this.volume)) {
    cap.comma write$                              %     write(cap_comma);
    volume extract.before.first.dash              %     String str = extract_before_first_dash(this.volume);
    format.volume write$                          %     write(format_volume(str));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require volume: " cite$ * warning$         %       warning("Require volume: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.start.number} {                  % void Entry::output_start_number(int required) {
  'required :=                                    %   this.required = required;
  number empty$ not {                             %   if (! empty(this.number)) {
    number extract.before.first.dash              %     String str = extract_before_first_dash(this.number);
    format.number write$                          %     write(format_number(str));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require number: " cite$ * warning$         %       warning("Require number: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.end.year} {                      % void Entry::output_end_year(int required) {
  'required :=                                    %   this.required = required;
  year empty$ not {                               %   if (! empty(this.year)) {
    year extract.after.last.dash                  %     String str = extract_after_last_dash(this.year);
    format.year write$                            %     write(format_year(str));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require year: " cite$ * warning$           %       warning("Require year: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.end.volume} {                    % void Entry::output_end_volume(int required) {
  'required :=                                    %   this.required = required;
  volume empty$ not {                             %   if (! empty(this.volume)) {
    cap.comma write$                              %     write(cap_comma);
    volume extract.after.last.dash                %     String str = extract_after_last_dash(this.volume);
    format.volume write$                          %     write(format_volume(str));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require volume: " cite$ * warning$         %       warning("Require volume: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.end.number} {                    % void Entry::output_end_number(int required) {
  'required :=                                    %   this.required = required;
  number empty$ not {                             %   if (! empty(this.number)) {
    number extract.after.last.dash                %     String str = extract_after_last_dash(this.number);
    format.number write$                          %     write(format_number(str));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require number: " cite$ * warning$         %       warning("Require number: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.url.or.doi} {                    % void Entry::output_url_or_doi(int required) {
  'required :=                                    %   this.required = required;
  url empty$ not {                                %   if (! empty(this.url)) {
    cap.period write$                             %     write(cap_period);
    url format.url write$                         %     write(format_url(this.url));
  } {                                             %   } else {
    doi empty$ not {                              %     if (! empty(this.doi)) {
      cap.period write$                           %       write(cap_period);
      cap.doi.url doi * format.url write$         %       write(format_url(cap_doi_url + this.doi));
    } {                                           %     } else {
      required {                                  %       if (required == 1) {
        "Require URL or DOI: " cite$ * warning$   %         warning("Require URL or DOI: " + this.cite);
      } 'skip$ if$                                %       }
    } if$                                         %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.url} {                           % void Entry::output_url(int required) {
  'required :=                                    %   this.required = required;
  url empty$ not {                                %   if (! empty(this.url)) {
    cap.period write$                             %     write(cap_period);
    url format.url write$                         %     write(format_url(this.url));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require URL: " cite$ * warning$            %        warning("Require URL: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {output.version} {                       % void Entry::output_version(int required) {
  'required :=                                    %   this.required = required;
  version empty$ not {                            %   if (! empty(this.version)) {
    cap.period write$                             %     write(cap_period);
    version format.version write$                 %     write(format_version(this.version));
  } {                                             %   } else {
    required {                                    %     if (required == 1) {
      "Require version: " cite$ * warning$        %       warning("Require version: " + this.cite);
    } 'skip$ if$                                  %     }
  } if$                                           %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {book.impl} {                            % void Entry::book_impl() {
  start.bibitem                                   %   start_bibitem();
  true output.author.or.editor                    %   output_author_or_editor(true);
  true output.series.volume.title                 %   output_series_volume_title(true);
  true output.mark                                %   output_mark(true);
  false output.translator                         %   output_translator(false);
  false output.edition                            %   output_edition(false);
  publisher empty$ not {                          %   if (! empty(this.publisher)) {
    true output.address                           %     output_address(true);
    true output.publisher                         %     output_publisher(true);
    cap.comma write$                              %     write(cap_comma);
  } {                                             %   } else {
    cap.period write$                             %     write(cap_period);
  } if$                                           %   }
  true output.year                                %   output_year(true);
  false output.pages                              %   output_pages(false);
  false output.citedate                           %   output_citedate(false);
  false output.url.or.doi                         %   output_url_or_doi(false);
  end.bibitem                                     %   end_bibitem();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {book} {                                 % void Entry::book() {
  "M" set.mark                                    %   set_mark("M");
  book.impl                                       %   book_impl();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {collection} {                           % void Entry::collection() {
  "G" set.mark                                    %   set_mark("G");
  book.impl                                       %   book_impl();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {proceedings} {                          % void Entry::proceedings() {
  "C" set.mark                                    %   set_mark("C");
  start.bibitem                                   %   start_bibitem();
  true output.editor                              %   output_editor(true);
  true output.series.volume.title                 %   output_series_volume_title(true);
  true output.mark                                %   output_mark(true);
  false output.translator                         %   output_translator(false);
  false output.edition                            %   output_edition(false);
  publisher empty$ not {                          %   if (! empty(this.publisher)) {
    true output.address                           %     output_address(true);
    true output.publisher                         %     output_publisher(true);
    cap.comma write$                              %     write(cap_comma);
  } {                                             %   } else {
    cap.period write$                             %     write(cap_period);
  } if$                                           %   }
  true output.year                                %   output_year(true);
  false output.pages                              %   output_pages(false);
  false output.citedate                           %   output_citedate(false);
  false output.url.or.doi                         %   output_url_or_doi(false);
  end.bibitem                                     %   end_bibitem();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {conference} {                           % void Entry::conference() {
  proceedings                                     %   proceedings();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {thesis.impl} {                          % void Entry::thesis_impl() {
  start.bibitem                                   %   start_bibitem();
  true output.author                              %   output_author(true);
  true output.title                               %   output_title(true);
  true output.mark                                %   output_mark(true);
  false output.translator                         %   output_translator(false);
  true output.address                             %   output_address(true);
  true output.school                              %   output_school(true);
  cap.comma write$                                %   write(cap_comma);
  true output.year                                %   output_year(true);
  false output.pages                              %   output_pages(false);
  false output.citedate                           %   output_citedate(false);
  false output.url.or.doi                         %   output_url_or_doi(false);
  end.bibitem                                     %   end_bibitem();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {phdthesis} {                            % void Entry::phdthesis() {
  "D" set.mark                                    %   set_mark("D");
  thesis.impl                                     %   thesis_impl();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {masterthesis} {                         % void Entry::masterthesis() {
  "D" set.mark                                    %   set_mark("D");
  thesis.impl                                     %   thesis_impl();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {bachelorthesis} {                       % void Entry::bachelorthesis() {
  "D" set.mark                                    %   set_mark("D");
  thesis.impl                                     %   thesis_impl();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {techreport} {                           % void Entry::techreport() {
  "R" set.mark                                    %   set_mark("R");
  start.bibitem                                   %   start_bibitem();
  true output.author                              %   output_author(true);
  true output.title                               %   output_title(true);
  false output.report.number                      %   output_report_number(false);
  true output.mark                                %   output_mark(true);
  false output.translator                         %   output_translator(false);
  false output.edition                            %   output_edition(false);
  false output.version                            %   output_version(false);
  institution empty$ not {                        %   if (! empty(this.institution)) {
    true output.address                           %     output_address(true);
    true output.institution                       %     output_institution(true);
    cap.comma write$                              %     write(cap_comma);
  } {                                             %   } else {
    cap.period write$                             %     write(cap_period);
  } if$                                           %   }
  true output.year                                %   output_year(true);
  false output.pages                              %   output_pages(false);
  false output.citedate                           %   output_citedate(false);
  false output.url.or.doi                         %   output_url_or_doi(false);
  end.bibitem                                     %   end_bibitem();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {standard} {                             % void Entry::standard() {
  "S" set.mark                                    %   set_mark("S");
  start.bibitem                                   %   start_bibitem();
  true output.author                              %   output_author(true);
  true output.title                               %   output_title(true);
  true output.mark                                %   output_mark(true);
  false output.translator                         %   output_translator(false);
  false output.edition                            %   output_edition(false);
  publisher empty$ not {                          %   if (! empty(this.publisher)) {
    true output.address                           %     output_address(true);
    true output.publisher                         %     output_publisher(true);
    cap.comma write$                              %     write(cap_comma);
  } {                                             %   } else {
    cap.period write$                             %     write(cap_period);
  } if$                                           %   }
  true output.year                                %   output_year(true);
  false output.pages                              %   output_pages(false);
  false output.citedate                           %   output_citedate(false);
  false output.url.or.doi                         %   output_url_or_doi(false);
  end.bibitem                                     %   end_bibitem();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {reference} {                            % void Entry::reference() {
  "K" set.mark                                    %   set_mark("K");
  start.bibitem                                   %   start_bibitem();
  false output.author.or.editor                   %   output_author_or_editor(false);
  true output.series.volume.title                 %   output_series_volume_title(true);
  true output.mark                                %   output_mark(true);
  false output.translator                         %   output_translator(false);
  false output.edition                            %   output_edition(false);
  publisher empty$ not {                          %   if (! empty(this.publisher)) {
    true output.address                           %     output_address(true);
    true output.publisher                         %     output_publisher(true);
    cap.comma write$                              %     write(cap_comma);
  } {                                             %   } else {
    cap.period write$                             %     write(cap_period);
  } if$                                           %   }
  true output.year                                %   output_year(true);
  false output.pages                              %   output_pages(false);
  false output.citedate                           %   output_citedate(false);
  false output.url.or.doi                         %   output_url_or_doi(false);
  end.bibitem                                     %   end_bibitem();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {manual} {                               % void Entry::manual() {
  reference                                       %   reference();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {periodical.impl} {                      % void Entry::periodical_impl() {
  start.bibitem                                   %   start_bibitem();
  false output.editor                             %   output_editor(false);
  true output.title                               %   output_title(true);
  true output.mark                                %   output_mark(true);
  cap.period write$                               %   write(cap_period);
  true output.start.year                          %   output_start_year(true);
  false output.start.volume                       %   output_start_volume(false);
  false output.start.number                       %   output_start_number(false);
  cap.dash write$                                 %   write(cap_dash);
  year contain.dash {                             %   if (contain_dash(this.year)) {
    true output.end.year                          %     output_end_year(true);
    false output.end.volume                       %     output_end_volume(false);
    false output.end.number                       %     output_end_number(false);
  } 'skip$ if$                                    %   }
  publisher empty$ not {                          %   if (! empty(this.publisher)) {
    true output.address                           %     output_address(true);
    true output.publisher                         %     output_publisher(true);
    cap.comma write$                              %     write(cap_comma);
  } {                                             %   } else {
    cap.period write$                             %     write(cap_period);
  } if$                                           %   }
  true output.start.year                          %   output_start_year(true);
  cap.dash write$                                 %   write(cap_dash);
  year contain.dash {                             %   if (contain_dash(this.year)) {
    true output.end.year                          %     output_end_year(true);
  } 'skip$ if$                                    %   }
  false output.citedate                           %   output_citedate(false);
  false output.url.or.doi                         %   output_url_or_doi(false);
  end.bibitem                                     %   end_bibitem();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {periodical} {                           % void Entry::periodical() {
  "J" set.mark                                    %   set_mark("J");
  periodical.impl                                 %   periodical_impl();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {newspaper} {                            % void Entry::newspaper() {
  "N" set.mark                                    %   set_mark("N");
  periodical.impl                                 %   periodical_impl();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {patent} {                               % void Entry::patent() {
  "P" set.mark                                    %   set_mark("P");
  start.bibitem                                   %   start_bibitem();
  true output.author                              %   output_author(true);
  true output.title                               %   output_title(true);
  true output.country                             %   output_country(true);
  true output.patentid                            %   output_patentid(true);
  true output.mark                                %   output_mark(true);
  cap.period write$                               %   write(cap_period);
  true output.date                                %   output_date(true);
  false output.citedate                           %   output_citedate(false);
  false output.url.or.doi                         %   output_url_or_doi(false);
  end.bibitem                                     %   end_bibitem();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {online} {                               % void Entry::online() {
  "EB" set.mark                                   %   set_mark("EB");
  start.bibitem                                   %   start_bibitem();
  false output.author                             %   output_author(false);
  true output.title                               %   output_title(true);
  true output.mark                                %   output_mark(true);
  publisher empty$ not {                          %   if (! empty(this.publisher)) {
    address empty$ not {                          %     if (! empty(this.address)) {
      true output.address                         %       output_address(true);
      true output.publisher                       %       output_publisher(true);
      cap.comma write$                            %       write(cap_comma);
    } {                                           %     } else {
      true output.publisher.no.address            %       output_publisher_no_address(true);
      cap.comma write$                            %       write(cap_comma);
    } if$                                         %     }
  } {                                             %   } else {
    cap.period write$                             %     write(cap_period);
  } if$                                           %   }
  true output.year                                %   output_year(true);
  false output.modifydate                         %   output_modifydate(false);
  true output.citedate                            %   output_citedate(true);
  true output.url                                 %   output_url(true);
  end.bibitem                                     %   end_bibitem();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {webpage} {                              % void Entry::online() {
  online                                          %   online();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {program.impl} {                         % void Entry::program_impl() {
  start.bibitem                                   %   start_bibitem();
  false output.author                             %   output_author(false);
  true output.title                               %   output_title(true);
  true output.mark                                %   output_mark(true);
  publisher empty$ not {                          %   if (! empty(this.publisher)) {
    true output.address                           %     output_address(true);
    true output.publisher                         %     output_publisher(true);
    cap.comma write$                              %     write(cap_comma);
  } {                                             %   } else {
    cap.period write$                             %     write(cap_period);
  } if$                                           %   }
  true output.year                                %   output_year(true);
  false output.citedate                           %   output_citedate(false);
  false output.url.or.doi                         %   output_url_or_doi(false);
  end.bibitem                                     %   end_bibitem();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {program} {                              % void Entry::program() {
  "CP" set.mark                                   %   set_mark("CP");
  program.impl                                    %   program_impl();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {database} {                             % void Entry::database() {
  "DB" set.mark                                   %   set_mark("DB");
  program.impl                                    %   program_impl();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {unpublished} {                          % void Entry::unpublished() {
  "H" set.mark                                    %   set_mark("H");
  start.bibitem                                   %   start_bibitem();
  true output.author                              %   output_author(true);
  true output.title                               %   output_title(true);
  true output.mark                                %   output_mark(true);
  cap.period write$                               %   write(cap_period);
  true output.year                                %   output_year(true);
  false output.citedate                           %   output_citedate(false);
  false output.url.or.doi                         %   output_url_or_doi(false);
  end.bibitem                                     %   end_bibitem();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {manuscript} {                           % void Entry::manuscript() {
  unpublished                                     %   unpublished();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {inbook.impl} {                          % void Entry::inbook_impl() {
  start.bibitem                                   %   start_bibitem();
  true output.author                              %   output_author(true);
  true output.title                               %   output_title(true);
  true output.mark                                %   output_mark(true);
  false output.translator                         %   output_translator(false);
  cap.double.slash write$                         %   write(cap_double_slash);
  false output.editor                             %   output_editor(false);
  true output.series.volume.booktitle             %   output_series_volume_booktitle(true);
  false output.edition                            %   output_edition(false);
  publisher empty$ not {                          %   if (! empty(this.publisher)) {
    true output.address                           %     output_address(true);
    true output.publisher                         %     output_publisher(true);
    cap.comma write$                              %     write(cap_comma);
  } {                                             %   } else {
    cap.period write$                             %     write(cap_period);
  } if$                                           %   }
  true output.year                                %   output_year(true);
  false output.pages                              %   output_pages(false);
  false output.citedate                           %   output_citedate(false);
  false output.url.or.doi                         %   output_url_or_doi(false);
  end.bibitem                                     %   end_bibitem();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {inbook} {                               % void Entry::inbook() {
  "M" set.mark                                    %   set_mark("M");
  inbook.impl                                     %   inbook_impl();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {incollection} {                         % void Entry::incollection() {
  "G" set.mark                                    %   set_mark("G");
  inbook.impl                                     %   inbook_impl();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {inproceedings} {                        % void Entry::inproceedings() {
  "C" set.mark                                    %   set_mark("C");
  inbook.impl                                     %   inbook_impl();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {article} {                              % void Entry::article() {
  "J" set.mark                                    %   set_mark("J");
  start.bibitem                                   %   start_bibitem();
  true output.author                              %   output_author(true);
  true output.title                               %   output_title(true);
  true output.mark                                %   output_mark(true);
  true output.journal                             %   output_journal(true);
  cap.comma write$                                %   write(cap_comma);
  true output.year                                %   output_year(true);
  false output.volume                             %   output_volume(false);
  false output.number                             %   output_number(false);
  false output.pages                              %   output_pages(false);
  false output.citedate                           %   output_citedate(false);
  false output.url.or.doi                         %   output_url_or_doi(false);
  end.bibitem                                     %   end_bibitem();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {news} {                                 % void Entry::news() {
  "N" set.mark                                    %   set_mark("N");
  start.bibitem                                   %   start_bibitem();
  true output.author                              %   output_author(true);
  true output.title                               %   output_title(true);
  true output.mark                                %   output_mark(true);
  true output.journal                             %   output_journal(true);
  cap.comma write$                                %   write(cap_comma);
  true output.date                                %   output_date(true);
  false output.number                             %   output_number(false);
  false output.citedate                           %   output_citedate(false);
  false output.url.or.doi                         %   output_url_or_doi(false);
  end.bibitem                                     %   end_bibitem();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {default.type} {                         % void Entry::default_type() {
  "Unsupported entry type for " cite$ * warning$  %   warning("Unsupported entry type for " + this.cite);
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {longest.label.pass} {                   % void longest_label_pass(Entry entry) {
  entry.count #1 + 'entry.count :=                %   entry_count = entry_count + 1;
  entry.count int.to.str$ 'label :=               %   this.label = int_to_str(entry_count);
  label width$ longest.label.width > {            %   if (width(this.label) > longest_label_width) {
    label 'longest.label :=                       %     longest_label = this.label;
    label width$ 'longest.label.width :=          %     longest_label_width = width(this.label);
  } 'skip$ if$                                    %   }
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {write.style.commands} {                 % void write_style_commands() {
  cmd.bibauthor write$                            %   write(cmd_bibauthor);
  newline$                                        %   writeln();
  cmd.bibeditor write$                            %   write(cmd_bibeditor);
  newline$                                        %   writeln();
  cmd.bibtranslator write$                        %   write(cmd_bibtranslator);
  newline$                                        %   writeln();
  cmd.bibtitle write$                             %   write(cmd_bibtitle);
  newline$                                        %   writeln();
  cmd.bibbooktitle write$                         %   write(cmd_bibbooktitle);
  newline$                                        %   writeln();
  cmd.bibjournal write$                           %   write(cmd_bibjournal);
  newline$                                        %   writeln();
  cmd.bibmark write$                              %   write(cmd_bibmark);
  newline$                                        %   writeln();
  cmd.bibcountry write$                           %   write(cmd_bibcountry);
  newline$                                        %   writeln();
  cmd.bibpatentid write$                          %   write(cmd_bibpatentid);
  newline$                                        %   writeln();
  cmd.bibedition write$                           %   write(cmd_bibedition);
  newline$                                        %   writeln();
  cmd.biborganization write$                      %   write(cmd_biborganization);
  newline$                                        %   writeln();
  cmd.bibaddress write$                           %   write(cmd_bibaddress);
  newline$                                        %   writeln();
  cmd.bibpublisher write$                         %   write(cmd_bibpublisher);
  newline$                                        %   writeln();
  cmd.bibinstitution write$                       %   write(cmd_bibinstitution);
  newline$                                        %   writeln();
  cmd.bibschool write$                            %   write(cmd_bibschool);
  newline$                                        %   writeln();
  cmd.bibvolume write$                            %   write(cmd_bibvolume);
  newline$                                        %   writeln();
  cmd.bibnumber write$                            %   write(cmd_bibnumber);
  newline$                                        %   writeln();
  cmd.bibversion write$                           %   write(cmd_bibversion);
  newline$                                        %   writeln();
  cmd.bibpages write$                             %   write(cmd_bibpages);
  newline$                                        %   writeln();
  cmd.bibmodifydate write$                        %   write(cmd_bibmodifydate);
  newline$                                        %   writeln();
  cmd.bibcitedate write$                          %   write(cmd_bibcitedate);
  newline$                                        %   writeln();
  cmd.bibyear write$                              %   write(cmd_bibyear);
  newline$                                        %   writeln();
  cmd.bibdate write$                              %   write(cmd_bibdate);
  newline$                                        %   writeln();
  cmd.biburl write$                               %   write(cmd_biburl);
  newline$                                        %   writeln();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {begin.bib} {                            % void begin_bib() {
  preamble$ empty$ not {                          %   if (! empty(premble)) {
    preamble$ write$                              %     write(premeable);
    newline$                                      %     writeln();
  } 'skip$ if$                                    %   }
  env.bibbegin write$                             %   write(env_bibbegin);
  "{" longest.label * "}" * write$                %   write("{" + longest.label + "}");
  newline$                                        %   writeln();
  write.style.commands                            %   write_style_commands();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {end.bib} {                              % void end_bib() {
  newline$                                        %   writeln();
  env.bibend write$                               %   write(env_bibend);
  newline$                                        %   writeln();
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
FUNCTION {initialize} {                           % void initialize() {
  #0 'entry.count :=                              %   entry_count = 0;
  #0 'longest.label.width :=                      %   longest_label_width = 0;
  "" 'longest.label :=                            %   longest_label = "";
}                                                 % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                  %
                                                  % void main() {
READ                                              %   List<Entry> entryList = read("<file>.bib");
EXECUTE {initialize}                              %   initialize();
ITERATE {longest.label.pass}                      %   for (Entry entry : entryList) {
                                                  %     longest_label_pass(entry);
                                                  %   }
EXECUTE {begin.bib}                               %   begin_bib();
ITERATE {call.type$}                              %   for (Entry entry : entryList) {
                                                  %     switch (typeof(entry)) {
                                                  %     case "book":
                                                  %        entry.book();
                                                  %        break;
                                                  %     case "article":
                                                  %        entry.article();
                                                  %        break;
                                                  %          .
                                                  %          .
                                                  %          .
                                                  %     case "incollection":
                                                  %        entry.incollection();
                                                  %        break;
                                                  %     case "misc":
                                                  %        entry.misc();
                                                  %        break;
                                                  %     default:
                                                  %        entry.default_type();
                                                  %     }
                                                  %   }
EXECUTE {end.bib}                                 %   end_bib();
                                                  % }
                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% End of file `GBT7714-2005.bst'
