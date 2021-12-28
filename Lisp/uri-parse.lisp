(defstruct uri-structure
  scheme
  userinfo
  host
  (port 80 :type integer)
  path
  query
  fragment)

(defun uri-parse (s)
  (let* ((strList (mapcar 'string (coerce s 'list)))
         (scheme (parse-scheme strList))
         (userinfo (parse-userinfo (second scheme)))
         (host (parse-host (second userinfo)))
         (port (parse-port (second host)))
         (path (parse-path (second port)))
         (query (parse-query (second path)))
         (fragment (parse-fragment (second query))))
    (make-uri-structure
                   :scheme (car scheme)
                   :userinfo (car userinfo)
                   :host (car host)
                   :port (car port)
                   :path (car path)
                   :query (car query)
                   :fragment (car fragment))))

(defun parse-scheme (l)
  (list (car l) (cdr l)))

(defun parse-userinfo (l)
  (list (car l) (cdr l)))

(defun parse-host (l)
  (list (car l) (cdr l)))

(defun parse-port (l)
  (list (parse-integer (car l)) (cdr l)))

(defun parse-path (l)
  (list (car l) (cdr l)))

(defun parse-query (l)
  (list (car l) (cdr l)))

(defun parse-fragment (l)
  (list (car l) (cdr l)))

(defun deleteFirst (lista)
  (append nil (cdr lista)))