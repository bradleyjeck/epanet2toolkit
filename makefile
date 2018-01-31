getdev:
	docker build -t rdevel . 

checkdev:
 	docker run -v "$(pwd)":/pkg -w /pkg rdevel R CMD check --as-cran epanet2toolkit_*.tar.gz
