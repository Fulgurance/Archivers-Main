class Target < ISM::Software
    
    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--enable-mt",
                            "--with-rmt=/usr/libexec/rmt"],
                            path: buildDirectoryPath)
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
