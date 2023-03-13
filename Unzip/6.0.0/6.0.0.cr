class Target < ISM::Software
    
    def build
        super

        makeSource([Ism.settings.makeOptions,"-f","unix/Makefile","generic"],buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource([Ism.settings.makeOptions,"prefix=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr","MANDIR=/usr/share/man/man1","-f","unix/Makefile","install"],buildDirectoryPath)
    end

end
