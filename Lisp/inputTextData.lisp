%
%  Chiamate corrette
%
(uri-parse "http://Uinfo@HostX:85/myServer/line/one?QueryXyZ#Fragment-01")	;V
(uri-parse "http://Uinfo@HostX:85/myServer/line/one?QueryXyZ")	;V
(uri-parse "http://Uinfo@HostX:85/myServer/line/one#Fragment-01")	;V 
(uri-parse "http://Uinfo@HostX/myServer/line/one")	;V	
(uri-parse "http://HostX/myServer/line/one")	;V	
(uri-parse "http://HostX.bis/myServer/line/one")	;V	
(uri-parse "http://192.168.1.34/myServer/line/one")	;V	
(uri-parse "http://Uinfo@192.168.1.34/myServer/line/one")	;V 

(uri-parse "http://Uinfo@HostX:85/myServer?QueryXyZ#Fragment-0")	;V
(uri-parse "http://Uinfo@HostX/myServer")	;V
(uri-parse "http://192.168.1.34/myServer")	;V
(uri-parse "http://Uinfo@192.168.1.234")	;V
(uri-parse "http://Uinfo@HostX:85/.?QueryXyZ#Fragment-01")	;V
(uri-parse "http://Uinfo@HostX")	;V
(uri-parse "http://HostX/myServer") 	;V

(uri-parse "http://UinfoHost/myServer/line/one?QueryXyZ#Fragment-01")	;V
(uri-parse "http://Uinfo@Host/myServer/line/one?Query#XyZ#Fragment-01")	;V

(uri-parse "mailto:Uinfo@HostX")	;V
(uri-parse "mailto:Uinfo@HostX.yz")	;V
(uri-parse "mailto:Uinfo@201.201.154")	;V
(uri-parse "mailto:Uinfo")	;V

(uri-parse "news:HostX")	;V
(uri-parse "news:HostX.yz")	;V
(uri-parse "news:201.201.154.255")	;V

(uri-parse "tel:Uinfo")	;V
(uri-parse "fax:Uinfo")	;V

(uri-parse "zos://Uinfo@HostX:85/ID44?QueryXyZ#Fragment-01")	;V
(uri-parse "zos://Uinfo@HostX:85/ID44val(id8Val)?QueryXyZ#Fragment-01")	;V
(uri-parse "zos://Uinfo@HostX:85/IDV.ID44val(id8Val)?QueryXyZ#Fragment-01")	;V
(uri-parse "zos://Uinfo@HostX:85/IDV44a.ID44b(id8Val)?QueryXyZ#Fragment-01")	;V
(uri-parse "zos://Uinfo@HostX:85/IDV.ID44val?QueryXyZ#Fragment-01")    ;V
(uri-parse "zos://Uinfo@HostX.yz/ID44?QueryXyZ")	;V
(uri-parse "zos://Uinfo@200.200.201.203/ID44?QueryXyZ#Fragment-01")	;V

(uri-parse "mailtO:Uinfo@HostX")	;V
(uri-parse "http://Uinfo@HostX:85/my Server/line/one?QueryXyZ#Fragment-01")	;V
(uri-parse "http://Uinfo@HostX:85/my Server/line/one?QueryXyZ#Fragment-01")	;V
(uri-parse "http://U info@HostX:85/my Server/line/one?Query XyZ#Fragment /01")	;V
(uri-parse "http://U info@Host X:85/my Server/line/one?QueryXyZ#Fragment-01")	;V
(uri-parse "htt p://Uinfo@HostX:85/my Server/line/one?QueryXyZ#Fragment-01")	;V
(uri-parse "zo s://U info@Host X:85/IDV44a.ID44 b(id8 Val)?Query XyZ#Fragment 01")	;V

%
%  Chiamate che devono generare errore 
%

(uri-parse "http//Uinfo@HostX:85/myServer/line/one?QueryXyZ#Fragment-01")	;V
(uri-parse "http://Uinfo@HostX:85myServer/line/one?QueryXyZ#Fragment-01")	;V
(uri-parse "http:/Uinfo@HostX:85/myServer/line/one?QueryXyZ#Fragment-01")	;V
(uri-parse "http://Uinfo@/myServer/line/one")	;V
(uri-parse "http://Uinfo#a@HostX:85/myServer/line/one?QueryXyZ#Fragment-01")	;V
(uri-parse "http://Uinfo@Host@XXX:85/myServer/line/one?QueryXyZ#Fragment-01")	;V
(uri-parse "http://Uinfo@Host:/myServer/line/one?QueryXyZ#Fragment-01")	;V
(uri-parse "http://Uinfo@HostX.:85/myServer/line/one?QueryXyZ#Fragment-01")	;V
(uri-parse "http://Uinfo@HostX.A:8s/myServer/line/one?QueryXyZ#Fragment-01")	;V
(uri-parse "http://Uinfo@HostX/myServer/line/o@ne?QueryXyZ#Fragment-01")	;V

(uri-parse "news:HostsX/A")	;V
(uri-parse "news:HostsX:A")	;V
(uri-parse "mailto:Uinfo@HostX.")	;V
(uri-parse "mailto://Uinfo@HostX/myServer/line/one?QueryXyZ#Fragment-01")	;V
(uri-parse "mailto:Uinfo@HostX/myServer")	;V
(uri-parse "tel:Uinfo@HostX")	;V
(uri-parse "fax:@Uinfo")	;V
(uri-parse "fax:Uin@fo")	;V


(uri-parse "zos://Uinfo@")	;V
(uri-parse "zos://Uinfo@HostX.yz/")	;V
(uri-parse "zos://Uinfo@HostX:85/.?QueryXyZ#Fragment-01")	;V
(uri-parse "zos://Uinfo@HostX:85/.(id8Val)#Fragment-01")	;V
(uri-parse "zos://Uinfo@HostX:85/IDV(id8).ID44val(id8Val)?QueryXyZ#Fragment-01")    ;V
(uri-parse "zos://Uinfo@HostX:85/IDV.ID44val.?QueryXyZ#Fragment-01")    ;V
(uri-parse "zos://Uinfo@200.200.201.203/ID441234567890123456789012345678901234567890A?QueryXyZ#Fragment-01")    ;V
(uri-parse "zos://Uinfo@HostX/1IDV.ID44val?QueryXyZ#Fragment-01")    ;V

%
% Chiamate alle funzioni ausiliarie
%

(uri-scheme(uri-parse "http://Uinfo@HostX:85/myServer/line/one?QueryXyZ#Fragment-01"))    ;V
(uri-userinfo(uri-parse "http://Uinfo@HostX:85/myServer/line/one?QueryXyZ#Fragment-01"))    ;V
(uri-host(uri-parse "http://Uinfo@HostX:85/myServer/line/one?QueryXyZ#Fragment-01"))    ;V
(uri-port(uri-parse "http://Uinfo@HostX:85/myServer/line/one?QueryXyZ#Fragment-01"))    ;V
(uri-path(uri-parse "http://Uinfo@HostX:85/myServer/line/one?QueryXyZ#Fragment-01"))    ;V
(uri-query(uri-parse "http://Uinfo@HostX:85/myServer/line/one?QueryXyZ#Fragment-01"))    ;V
(uri-fragment(uri-parse "http://Uinfo@HostX:85/myServer/line/one?QueryXyZ#Fragment-01"))    ;V

(uri-display(uri-parse "http://Uinfo@HostX:85/myServer/line/one?QueryXyZ#Fragment-01"))
(uri-display(uri-parse "http://Uinfo@HostX:85/myServer/line/one?QueryXyZ#Fragment-01") *standard-output*) 