class Target < ISM::Software
    
    def configure
        super

        if option("Pass1")
            configureSource([   "--prefix=/usr",
                                "--host=#{Ism.settings.chrootTarget}",
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
    end

end
