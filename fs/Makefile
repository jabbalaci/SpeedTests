v1:
	dotnet publish -o dist -c Release
	mv dist/fs ./main
	mv dist/fs.dll .
	mv dist/fs.runtimeconfig.json .

clean:
	rm ./main; rm -fr ./bin; rm -fr ./dist; rm -fr ./obj; rm ./fs.dll; rm ./fs.runtimeconfig.json
