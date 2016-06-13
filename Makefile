ASPELL = /usr/bin/aspell
ASPELL_FLAGS = 
PREZIP = /usr/bin/word-list-compress
DESTDIR = 
dictdir = /usr/lib/aspell
datadir = /usr/lib/aspell

# Generated with Aspell Dicts "proc" script version 0.60.3

lang = hil
version = 0.11-0

cwl_files = hil.cwl
data_files = hil.dat
doc_files = README COPYING Copyright
extra_files = configure info Makefile.pre
multi_files = hil.multi
rws_files = hil.rws

distdir=aspell5-${lang}-${version}

all: ${rws_files} ${data_files}

install: all
	mkdir -p ${DESTDIR}${dictdir}/
	cp ${rws_files} ${multi_files} ${DESTDIR}${dictdir}/
	cd ${DESTDIR}${dictdir}/ && chmod 644 ${rws_files} ${multi_files}
	mkdir -p ${DESTDIR}${datadir}/
	cp ${data_files} ${DESTDIR}${datadir}/
	cd ${DESTDIR}${datadir}/ && chmod 644 ${data_files}

clean:
	rm -f ${rws_files}

distclean: clean
	rm -f Makefile

maintainer-clean: distclean
	rm -f ${multi_files} configure Makefile.pre

uninstall:
	-cd ${DESTDIR}${dictdir}/ && rm ${rws_files} ${multi_files} ${link_files}
	-cd ${DESTDIR}${datadir}/ && rm ${data_files}

dist: ${cwl_files}
	perl proc
	./configure
	@make dist-nogen

dist-nogen:
	-rm -r ${distdir}.tar.bz2 ${distdir}
	mkdir ${distdir}
	cp -p ${extra_files} ${cwl_files} ${multi_files} ${doc_files} ${data_files} ${distdir}/
	-test -e doc  && mkdir ${distdir}/doc  && chmod 755 ${distdir}/doc  && cp -pr doc/* ${distdir}/doc/
	-test -e misc && mkdir ${distdir}/misc && chmod 755 ${distdir}/misc && cp -pr misc/* ${distdir}/misc/
	tar cf ${distdir}.tar ${distdir}/
	bzip2 -9 ${distdir}.tar
	rm -r ${distdir}/

distcheck:
	tar xfj ${distdir}.tar.bz2
	cd ${distdir} && ./configure && make

rel:
	mv ${distdir}.tar.bz2 ../rel


hil.rws: hil.cwl


.SUFFIXES: .cwl .rws .wl

.cwl.rws:
	${PREZIP} d < $< | ${ASPELL} ${ASPELL_FLAGS} --lang=hil create master ./$@

.wl.cwl:
	cat $< | LC_COLLATE=C sort -u | ${PREZIP} c > $@

.pz:
	${PREZIP} d < $< > $@

