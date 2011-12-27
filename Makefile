.PHONY : all html open mostlyclean clean distclean
.PHONY : docs/_build/html/index.html

all : html

html : docs/_build/html/index.html

docs/_build/html/index.html : bin/activate
	source bin/activate && make -C docs html

open : docs/_build/html/index.html
	open docs/_build/html/index.html

bin/activate :
	python virtualenv.py .
	bin/pip install -r requirements.txt

mostlyclean :
	$(RM) virtualenv.pyc

clean : mostlyclean
	make -C docs clean

distclean : clean
	rm -rf bin lib include .Python
