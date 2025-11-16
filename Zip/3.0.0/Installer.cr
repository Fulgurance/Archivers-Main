class Target < ISM::Software
    
    def build
        super

        makeSource( arguments:   "-f unix/Makefile generic CC=\"gcc -std=gnu89\"",
                    path:       buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource( arguments:   "prefix=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr MANDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/share/man/man1 -f unix/Makefile install",
                    path:       buildDirectoryPath)
    end

end
