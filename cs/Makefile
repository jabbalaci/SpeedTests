v1:
	dotnet publish -o dist -c Release
	mv dist/cs ./main
	mv dist/cs.dll .
	mv dist/cs.runtimeconfig.json .

clean:
	rm ./main; rm -fr ./bin; rm -fr ./dist; rm -fr ./obj; rm ./cs.dll; rm ./cs.runtimeconfig.json
