class Target < ISM::Software
    
    def configure
        super

        if option("Pass1")
            configureSource([   "--prefix=/usr",
                                "--host=#{Ism.settings.target}",
                                "--build=$(build-aux/config.guess)"],
                                buildDirectoryPath)
        else
            configureSource(arguments: [   "--prefix=/usr"],
                            path: buildDirectoryPath,
                            environment: {"FORCE_UNSAFE_CONFIGURE" => "1"})
        end
    end
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        if !option("Pass1")
            makeSource(["-C","doc","DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install-html","docdir=/usr/share/doc/tar-1.34"],buildDirectoryPath)
        end
    end

end
