class Target < ISM::Software
    
    def build
        super

        makeSource(["-f","unix/Makefile","generic_gcc"],buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource(["prefix=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr","MANDIR=/usr/share/man/man1","-f","unix/Makefile","install"],buildDirectoryPath)
    end

end
